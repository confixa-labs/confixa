#!/bin/bash
# scripts/release.sh - Improved release management script

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Color codes for output
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly NC='\033[0m' # No Color

# Logging functions
log_error() { echo -e "${RED}Error: $1${NC}" >&2; }
log_success() { echo -e "${GREEN}$1${NC}"; }
log_warning() { echo -e "${YELLOW}Warning: $1${NC}"; }
log_info() { echo "$1"; }

# Help function
show_help() {
    cat << EOF
Usage: ./scripts/release.sh [options]

Options:
  -t, --type      Version bump type (patch|minor|major) [optional when -r is used]
                  If not provided with -r, removes postfix from current version
  -m, --message   Commit message (required)
  -b, --branch    Source branch name [default: current branch]
  -n, --notes     Path to release notes file [optional]
  -r, --release   Create GitHub release [default: false]
  -p, --postfix   Postfix to add to the version (e.g., alpha, beta) [optional]
  -d, --dry-run   Perform a dry run without making changes [default: false]
  --no-push      Skip pushing changes to remote [default: false]

Examples:
  ./scripts/release.sh -t minor -m "New feature release" -b develop -n release-notes.md -r -p beta
  ./scripts/release.sh -m "Release version" -r  # Removes postfix and creates release
  ./scripts/release.sh -t patch -m "Bug fix" -d  # Dry run a patch release
EOF
}

# Check if required commands exist
check_dependencies() {
    local missing_deps=()
    for cmd in git gh sed awk grep; do
        if ! command -v "$cmd" &> /dev/null; then
            missing_deps+=("$cmd")
        fi
    done

    if [ ${#missing_deps[@]} -ne 0 ]; then
        log_error "Missing required dependencies: ${missing_deps[*]}"
        exit 1
    fi
}

# Validate semantic version format
validate_version() {
    local version=$1
    if ! echo "$version" | grep -qE '^[0-9]+\.[0-9]+\.[0-9]+(-[a-zA-Z0-9.]+)?$'; then
        log_error "Invalid version format: $version"
        exit 1
    fi
}

# Version processing function for semantic versions
process_version() {
    local version=$1
    local type=$2
    local postfix=$3
    local is_release=$4

    validate_version "$version"

    # Remove any existing postfix
    local base_version=$(echo "$version" | sed 's/-.*$//')

    # If no type is provided and it's a release, just remove the postfix
    if [[ -z "$type" ]] && [[ "$is_release" == true ]]; then
        echo "$base_version"
        return
    fi

    # Otherwise proceed with normal version bumping
    IFS='.' read -r major minor patch <<< "$base_version"

    case $type in
        major)
            major=$((major + 1))
            minor=0
            patch=0
            ;;
        minor)
            minor=$((minor + 1))
            patch=0
            ;;
        patch)
            patch=$((patch + 1))
            ;;
    esac

    local new_version="$major.$minor.$patch"
    if [[ -n "$postfix" ]]; then
        new_version="$new_version-$postfix"
    fi

    validate_version "$new_version"
    echo "$new_version"
}

# Function to update Chart.yaml version with backup
update_chart_version() {
    local new_version=$1
    local dry_run=$2
    local chart_file="charts/helm/Chart.yaml"

    if [[ ! -f "$chart_file" ]]; then
        log_error "Chart.yaml not found at $chart_file"
        exit 1
    fi

    if [[ "$dry_run" == true ]]; then
        log_info "Would update $chart_file version to: $new_version"
        return
    fi

    # Create backup
    cp "$chart_file" "${chart_file}.bak"

    # Update version in Chart.yaml
    if [[ "$OSTYPE" == "darwin"* ]]; then
        sed -i '' "s/^version:.*$/version: $new_version/" "$chart_file"
        sed -i '' "s/^appVersion:.*$/appVersion: $new_version/" "$chart_file"
    else
        sed -i "s/^version:.*$/version: $new_version/" "$chart_file"
        sed -i "s/^appVersion:.*$/appVersion: $new_version/" "$chart_file"
    fi

    log_success "Updated $chart_file version to: $new_version"
}

# Function to update renovate configuration with backup
update_renovate_version() {
    local new_version=$1
    local dry_run=$2
    local renovate_file="renovate.json"

    if [[ ! -f "$renovate_file" ]]; then
        log_warning "renovate.json not found, skipping update"
        return
    fi

    if [[ "$dry_run" == true ]]; then
        log_info "Would update $renovate_file version to: $new_version"
        return
    fi

    # Create backup
    cp "$renovate_file" "${renovate_file}.bak"

    if [[ "$OSTYPE" == "darwin"* ]]; then
        sed -i '' "s/\"currentValue\":.*$/\"currentValue\": \"$new_version\",/" "$renovate_file"
    else
        sed -i "s/\"currentValue\":.*$/\"currentValue\": \"$new_version\",/" "$renovate_file"
    fi

    log_success "Updated $renovate_file version to: $new_version"
}

# Function to create GitHub release with retry mechanism
create_github_release() {
    local version=$1
    local message=$2
    local notes_file=$3
    local dry_run=$4
    local max_retries=3
    local retry_count=0

    if [[ "$dry_run" == true ]]; then
        log_info "Would create GitHub release: v$version"
        return
    fi

    # If notes file is provided, validate it exists
    if [[ -n "$notes_file" ]]; then
        if [[ ! -f "$notes_file" ]]; then
            log_error "Release notes file not found: $notes_file"
            exit 1
        fi
        local release_notes=$(<"$notes_file")
    else
        local release_notes=$message
    fi

    while (( retry_count < max_retries )); do
        if gh release create "v$version" \
            --title "v$version" \
            --notes "$release_notes" \
            --target "$(git rev-parse HEAD)"; then
            log_success "Successfully created GitHub release v$version"
            return 0
        fi

        ((retry_count++))
        if (( retry_count < max_retries )); then
            log_warning "Failed to create release, retrying in 5 seconds... (attempt $retry_count of $max_retries)"
            sleep 5
        fi
    done

    log_error "Failed to create GitHub release after $max_retries attempts"
    return 1
}

calculate_next_version() {
    local version=$1
    IFS='.' read -r major minor patch <<< "$(echo "$version" | sed 's/-.*$//')"
    local next_version="$major.$((minor + 1)).0-rc"
    echo "$next_version"
}

# Function to create pull request
create_pull_request() {
    local version=$1
    local message=$2
    local branch=$3
    local version_type=$4
    local is_release=$5

    # Only create PR when no version type is provided and release is true
    if [[ "$is_release" != true ]]; then
        return 0
    fi

    # Check if GitHub CLI is installed
    if ! command -v gh &> /dev/null; then
        log_error "Error: GitHub CLI (gh) is not installed. Please install it to create pull requests."
        log_error "Installation instructions: https://cli.github.com/"
        return 1
    fi

    local pr_title="Release v$version"
    local pr_body="<!--
Note on DCO:

If the DCO action in the integration test fails, one or more of your commits are not signed off. Please click on the *Details* link next to the DCO action for instructions on how to resolve this.
-->

# Checklist

* [ ] I have bumped the chart version according to [versioning](https://github.com/confixa-labs/confixa/blob/main/CONTRIBUTING.md#versioning)
* [ ] I have updated the documentation according to [documentation](https://github.com/confixa-labs/confixa/blob/main/CONTRIBUTING.md#documentation)
* [ ] I have updated the chart changelog with all the changes that come with this pull request according to [changelog](https://github.com/confixa-labs/confixa/blob/main/CONTRIBUTING.md#changelog).
* [ ] Any new values are backwards compatible and/or have sensible default.
* [ ] I have signed off all my commits as required by [DCO](https://github.com/confixa-labs/confixa/blob/main/CONTRIBUTING.md).
* [ ] My build is green [troubleshooting builds](https://example.com/build-status).

<!-- Changes are automatically published when merged to 'main'. They are not published on branches. -->

Release Message: $message"

    echo "Creating pull request for main branch..."
    if ! gh pr create \
        --title "$pr_title" \
        --body "$pr_body" \
        --base "main" \
        --head "$branch"; then
        echo "Error: Failed to create pull request"
        return 1
    fi

    log_success "Successfully created pull request for main branch"
}

# Main release function with improved error handling and dry run support
create_release() {
    local version_type=""
    local commit_message=""
    local source_branch=""
    local notes_file=""
    local create_gh_release=false
    local postfix=""
    local dry_run=false
    local skip_push=false

    # Parse arguments with improved validation
    while [[ $# -gt 0 ]]; do
        case $1 in
            -t|--type)
                [[ -z "$2" ]] && { log_error "Version type required for -t|--type"; exit 1; }
                version_type="$2"
                shift 2
                ;;
            -m|--message)
                [[ -z "$2" ]] && { log_error "Message required for -m|--message"; exit 1; }
                commit_message="$2"
                shift 2
                ;;
            -b|--branch)
                [[ -z "$2" ]] && { log_error "Branch name required for -b|--branch"; exit 1; }
                source_branch="$2"
                shift 2
                ;;
            -n|--notes)
                [[ -z "$2" ]] && { log_error "Notes file path required for -n|--notes"; exit 1; }
                notes_file="$2"
                shift 2
                ;;
            -r|--release)
                create_gh_release=true
                shift
                ;;
            -p|--postfix)
                [[ -z "$2" ]] && { log_error "Postfix value required for -p|--postfix"; exit 1; }
                postfix="$2"
                shift 2
                ;;
            -d|--dry-run)
                dry_run=true
                shift
                ;;
            --no-push)
                skip_push=true
                shift
                ;;
            *)
                log_error "Unknown option: $1"
                show_help
                exit 1
                ;;
        esac
    done

    # Validate inputs
    [[ -z "$commit_message" ]] && { log_error "Commit message is required"; show_help; exit 1; }
    [[ -n "$version_type" ]] && [[ ! "$version_type" =~ ^(patch|minor|major)$ ]] && {
        log_error "Invalid version type. Must be patch, minor, or major"; exit 1;
    }

    # Set default source branch to current branch if not specified
    [[ -z "$source_branch" ]] && source_branch=$(git rev-parse --abbrev-ref HEAD)

    # Check dependencies before proceeding
    check_dependencies

    if [[ "$dry_run" == true ]]; then
        log_info "=== DRY RUN MODE ==="
    fi

    # Get and validate current version
    local chart_file="charts/helm/Chart.yaml"
    [[ ! -f "$chart_file" ]] && { log_error "Chart.yaml not found"; exit 1; }

    local current_version=$(grep '^version:' "$chart_file" | awk '{print $2}')
    local new_version=$(process_version "$current_version" "$version_type" "$postfix" "$create_gh_release")
    local version_tag="v$new_version"
    local release_branch="release/$version_tag"

    log_info "Current version: $current_version"
    log_info "New version: $new_version"

    local next_version=$(calculate_next_version "$new_version")
    log_info "Next version: $next_version"
    echo "$next_version" > "version_next.txt"

    if [[ "$dry_run" == false ]]; then
        # Create and switch to release branch
        git checkout -b "$release_branch" || {
            log_error "Failed to create new branch: $release_branch"
            exit 1
        }

        # Update versions in files
        update_chart_version "$new_version" "$dry_run"
        update_renovate_version "$new_version" "$dry_run"
        echo "$new_version" > version.txt

        # Update documentation
        if [[ -f "$SCRIPT_DIR/helm-docs.sh" ]]; then
            log_info "Updating Chart documentation..."
            "$SCRIPT_DIR/helm-docs.sh"
        fi

        # Commit changes
        git add . || { log_error "Failed to stage changes"; exit 1; }
        git commit -m "$commit_message ($version_tag)" || {
            log_error "Failed to commit changes"
            exit 1
        }

        # Create tag
        git tag -a "$version_tag" -m "$commit_message ($version_tag)" || {
            log_error "Failed to create tag"
            exit 1
        }

        # Push changes if not skipped
        if [[ "$skip_push" == false ]]; then
            git push origin "$release_branch" || {
                log_error "Failed to push branch"
                exit 1
            }
            git push origin "$version_tag" || {
                log_error "Failed to push tag"
                exit 1
            }
        fi

        # Create GitHub release if requested
        if [[ "$create_gh_release" == true ]]; then
            create_github_release "$new_version" "$commit_message" "$notes_file" "$dry_run"
            # Create pull request only when no version type is provided and release is true
            create_pull_request "$new_version" "$commit_message" "$release_branch" "$version_type" "$create_gh_release"
        fi
    fi

    log_success "Release process completed successfully"
    [[ "$dry_run" == true ]] && log_info "=== DRY RUN COMPLETED ==="
}

# Main script execution
if [[ "${1:-}" == "--help" ]] || [[ "${1:-}" == "-h" ]]; then
    show_help
    exit 0
fi

create_release "$@"
