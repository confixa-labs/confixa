#!/bin/bash
# Script to run helm-docs using Docker
# Reference: https://github.com/norwoodj/helm-docs

set -euxo pipefail

# Configurable parameters
DOCKER_IMAGE="jnorwood/helm-docs"
HELM_DOCS_VERSION="v1.9.1"

# Get the root directory of the repository
REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
echo "Repository root: $REPO_ROOT"

# Check if Docker is installed and running
if ! command -v docker &>/dev/null; then
    echo "Error: Docker is not installed or not available in PATH." >&2
    exit 1
fi

if ! docker info &>/dev/null; then
    echo "Error: Docker is not running. Please start Docker and try again." >&2
    exit 1
fi

echo "Running Helm-Docs with Docker image: $DOCKER_IMAGE:$HELM_DOCS_VERSION"

docker run --rm \
    -v "$REPO_ROOT:/helm-docs" \
    -u "$(id -u)" \
    "$DOCKER_IMAGE:$HELM_DOCS_VERSION"

echo "Helm-Docs run completed successfully."
