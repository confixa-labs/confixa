#!/bin/bash

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

# Ensure script exits on first error
set -e

# Read the version from version_next.txt
VERSION_FILE="version_next.txt"
if [[ ! -f "$VERSION_FILE" ]]; then
    log_error "version_next.txt not found. Exiting."
    exit 1
fi

VERSION=$(cat "$VERSION_FILE" | tr -d '[:space:]')
if [[ -z "$VERSION" ]]; then
    log_error "version_next.txt is empty. Exiting."
    exit 1
fi

BRANCH_NAME="release/v$VERSION"

# Fetch the latest branches from origin
git fetch origin

# Check if the branch already exists on origin
if git ls-remote --exit-code --heads origin "$BRANCH_NAME" > /dev/null 2>&1; then
    log_info "Branch $BRANCH_NAME already exists on origin. Checking out..."
    git checkout "$BRANCH_NAME"
else
    log_info "Branch $BRANCH_NAME does not exist. Creating and pushing..."
    git checkout -b "$BRANCH_NAME"
    git push -u origin "$BRANCH_NAME"
    log_success "Branch $BRANCH_NAME created and pushed successfully."
fi

# Update the version in the Helm chart
CHART_FILE="./charts/helm/Chart.yaml"

if [[ ! -f "$CHART_FILE" ]]; then
    log_error "Chart.yaml not found. Exiting."
    exit 1
fi

# Use compatible sed command for macOS and Linux
if [[ "$OSTYPE" == "darwin"* ]]; then
    sed -i '' "s/^version:.*/version: $VERSION/" "$CHART_FILE"
else
    sed -i "s/^version:.*/version: $VERSION/" "$CHART_FILE"
fi

log_success "Updated Helm chart version to $VERSION."

# Update the version.txt file
VERSION_TXT_FILE="version.txt"
echo "$VERSION" > "$VERSION_TXT_FILE"
log_success "Updated version.txt to $VERSION."

# Commit and push the changes
git add "$CHART_FILE" "$VERSION_TXT_FILE"
git commit -m "Update Helm chart and version.txt to $VERSION"
git push origin "$BRANCH_NAME"
log_success "Pushed updated version changes to $BRANCH_NAME."
