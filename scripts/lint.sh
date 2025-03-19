#!/bin/bash
# This script runs the chart-testing tool locally. 
# It simulates the linting that is also done by the GitHub Action.
# Reference: https://github.com/helm/chart-testing

set -euxo pipefail

# Configurable parameters
DOCKER_IMAGE="quay.io/helmpack/chart-testing"
CT_VERSION="v3.10.0"
SRCROOT="$(cd "$(dirname "$0")/.." && pwd)"

# Required configuration files
CT_CONFIG="$SRCROOT/.github/configs/ct-lint.yaml"
LINT_CONF="$SRCROOT/.github/configs/lintconf.yaml"

echo "Repository root: $SRCROOT"

# Ensure required files exist
if [[ ! -f "$CT_CONFIG" ]]; then
    echo "Error: Configuration file '$CT_CONFIG' not found." >&2
    exit 1
fi

if [[ ! -f "$LINT_CONF" ]]; then
    echo "Error: Lint configuration file '$LINT_CONF' not found." >&2
    exit 1
fi

# Check if Docker is installed and running
if ! command -v docker &>/dev/null; then
    echo "Error: Docker is not installed or not available in PATH." >&2
    exit 1
fi

if ! docker info &>/dev/null; then
    echo "Error: Docker is not running. Please start Docker and try again." >&2
    exit 1
fi

echo -e "\n-- Linting all Helm Charts --\n"

# Run chart-testing tool
docker run --rm \
    -v "$SRCROOT:/workdir" \
    --entrypoint /bin/sh \
    "$DOCKER_IMAGE:$CT_VERSION" \
    -c "
        cd /workdir && \
        ct lint \
        --config .github/configs/ct-lint.yaml \
        --lint-conf .github/configs/lintconf.yaml \
        --debug
    "

echo -e "\n-- Helm Chart Linting Completed Successfully --\n"
