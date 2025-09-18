#!/bin/bash
set -e

echo "=== Marketplace Values Preprocessing ==="

# Create final_values directory that the deployer scripts expect
mkdir -p /data/final_values

# Copy all values files from /data/values to /data/final_values
if [ -d "/data/values" ] && [ "$(ls -A /data/values 2>/dev/null)" ]; then
    echo "Copying values from /data/values to /data/final_values..."
    cp -r /data/values/* /data/final_values/ 2>/dev/null || true
    
    echo "Values preprocessing completed successfully"
    echo "Available parameters:"
    ls -la /data/final_values/ | head -10
else
    echo "Warning: /data/values directory is empty or does not exist"
fi

echo "=== Preprocessing Complete ==="