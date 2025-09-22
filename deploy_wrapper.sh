#!/bin/bash
set -e

echo "=== Confixa Marketplace Deployer Starting ==="
echo "Deployment started at: $(date)"
echo "Running in namespace: ${NAMESPACE:-unknown}"
echo "Kubernetes client version: $(kubectl version --client --short 2>/dev/null || echo 'kubectl version check failed')"

# Comprehensive environment debugging
echo "=== Environment Debug Info ==="
echo "Current user: $(whoami)"
echo "Current directory: $(pwd)"
echo "Available environment variables:"
env | grep -E "(NAMESPACE|NAME|DEPLOYER)" | sort || echo "No relevant env vars found"

echo "=== File System Analysis ==="
echo "Contents of /data:"
find /data -type f -exec ls -la {} \; 2>/dev/null | head -20
echo "Contents of /data/values (if exists):"
ls -la /data/values/ 2>/dev/null | head -10 || echo "/data/values not found or empty"

# Step 1: Install Application CRD with error handling
echo "=== Installing Application CRD ==="
if /bin/install_app_crd.py; then
    echo "Application CRD installation successful"
else
    echo "Application CRD installation failed with exit code $?"
    kubectl get crd applications.app.k8s.io 2>&1 || echo "CRD check failed"
    exit 1
fi

# Step 2: Values preprocessing with detailed logging
echo "=== Values Preprocessing ==="
if /bin/preprocess_values.sh; then
    echo "Values preprocessing successful"
    echo "Post-preprocessing file check:"
    ls -la /data/final_values/ 2>/dev/null | head -10 || echo "/data/final_values not created"
else
    echo "Values preprocessing failed with exit code $?"
    exit 1
fi

# Step 3: Parameter validation before deployment
echo "=== Parameter Validation ==="
echo "Testing critical parameter extraction:"
NAME_TEST=$(/bin/print_config.py --xtype NAME --values_mode raw 2>&1) || echo "NAME extraction failed"
NAMESPACE_TEST=$(/bin/print_config.py --xtype NAMESPACE --values_mode raw 2>&1) || echo "NAMESPACE extraction failed"
echo "NAME: '${NAME_TEST}'"
echo "NAMESPACE: '${NAMESPACE_TEST}'"

if [ -z "${NAME_TEST}" ] || [ -z "${NAMESPACE_TEST}" ]; then
    echo "Critical parameters missing, aborting deployment"
    exit 1
fi

# Step 4: Pre-deployment cluster connectivity test
echo "=== Cluster Connectivity Test ==="
kubectl cluster-info 2>&1 || echo "Cluster info failed"
kubectl auth can-i create applications.app.k8s.io 2>&1 || echo "RBAC check failed"

echo "=== Starting Helm-based Deployment ==="
echo "Deployment handoff at: $(date)"

# Execute normal deployment with error handling
if ! /bin/deploy.sh; then
    echo "Deployment failed at: $(date)"
    echo "=== Post-failure Diagnostics ==="
    kubectl get events --sort-by='.lastTimestamp' -n "${NAMESPACE_TEST}" 2>&1 | tail -10 || echo "Events check failed"
    exit 1
fi

echo "Deployment completed successfully at: $(date)"