#!/bin/bash

# Ensure the script stops on errors, undefined variables, or failed pipes
set -euxo pipefail

# Validate and parse the input
depName="${1:-}"
if [[ -z "$depName" ]]; then
  echo "Error: Missing argument 'depName'" >&2
  echo "Example usage: $0 confixa" >&2
  exit 1
fi

# Derive the chart name
chartName=$(echo "$depName" | sed -e "s+^confixa/++" -e "s+^confixa-labs/++")
echo "Processing chart: $chartName"
echo "----------------------------------------"

# Define the chart directory
parentDir="./charts/${chartName}"

# Check if the Chart.yaml file exists
chartFile="${parentDir}/Chart.yaml"
if [[ ! -f "$chartFile" ]]; then
  echo "Error: Chart.yaml file not found in $parentDir" >&2
  exit 1
fi

# Bump the chart version by one patch version
currentVersion=$(grep '^version:' "$chartFile" | awk '{print $2}')
if [[ -z "$currentVersion" ]]; then
  echo "Error: No 'version' field found in $chartFile" >&2
  exit 1
fi

major=$(echo "$currentVersion" | cut -d. -f1)
minor=$(echo "$currentVersion" | cut -d. -f2)
patch=$(echo "$currentVersion" | cut -d. -f3)
newVersion="${major}.${minor}.$((patch + 1))"
sed -i.bak "s/^version:.*/version: ${newVersion}/" "$chartFile"
echo "Updated chart version to: $newVersion"

# Display the updated Chart.yaml for verification
echo "Updated Chart.yaml:"
cat "$chartFile"

# Clean up backup file
rm -f "${chartFile}.bak"
