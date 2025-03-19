#!/bin/bash
# cli.sh - Main CLI script with improved error handling and validation

set -euo pipefail  # Enable strict error handling

# Set script directory
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

# Help function
show_help() {
    cat << EOF
Usage: ./cli.sh <command> [options]

Commands:
  create-docs              Generate documentation
  lint-charts             Run linting on charts
  bump-version            Bump version using renovate
  release                 Create a new release
  next-version-branch     Create Next Version Branch

Release options:
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
  ./release.sh -t minor -m "New feature release" -b develop -n release-notes.md -r -p beta
  ./release.sh -m "Release version" -r  # Removes postfix and creates release
  ./release.sh -t patch -m "Bug fix" -d  # Dry run a patch release
EOF
}

# Check if required commands exist
check_dependencies() {
    local missing_deps=()
    for cmd in git helm docker gh sed awk grep; do
        if ! command -v "$cmd" &> /dev/null; then
            missing_deps+=("$cmd")
        fi
    done

    if [ ${#missing_deps[@]} -ne 0 ]; then
        log_error "Missing required dependencies: ${missing_deps[*]}"
        exit 1
    fi
}

# Validate script existence
validate_script() {
    local script_path="$SCRIPT_DIR/scripts/$1"
    if [ ! -f "$script_path" ]; then
        log_error "Script not found: $script_path"
        exit 1
    fi
    if [ ! -x "$script_path" ]; then
        log_error "Script is not executable: $script_path"
        exit 1
    fi
}

# Execute script with error handling
execute_script() {
    local script_name="$1"
    shift
    validate_script "$script_name"

    "$SCRIPT_DIR/scripts/$script_name" "$@";
}

# Main command handler
main() {
    # Check if no arguments provided
    if [ $# -eq 0 ]; then
        show_help
        exit 1
    fi

    # Check dependencies before proceeding
    check_dependencies

    case $1 in
        create-docs)
            execute_script "helm-docs.sh"
            log_success "Documentation generated successfully"
            ;;
        lint-charts)
            shift
            execute_script "lint.sh" "$@"
            log_success "Linting completed successfully"
            ;;
        bump-version)
            execute_script "renovate-bump-version.sh"
            log_success "Version bumped successfully"
            ;;
        release)
            shift
            # Validate required release options
            if [[ $* != *"-m"* ]] && [[ $* != *"--message"* ]]; then
                log_error "Commit message is required for release"
                show_help
                exit 1
            fi
            execute_script "release.sh" "$@"
            log_success "Release completed successfully"
            ;;
        next-version-branch)
            shift
            execute_script "create-next-version-branch.sh" "$@"
            log_success "Next version branch created successfully"
            ;;
        help|-h|--help)
            show_help
            ;;
        *)
            log_error "Unknown command '$1'"
            show_help
            exit 1
            ;;
    esac
}

# Trap errors
trap 'log_error "An error occurred. Exiting..."' ERR

# Execute main function
main "$@"
