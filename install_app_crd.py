#!/usr/bin/env python3
import subprocess
import sys

def install_application_crd():
    try:
        # Check if CRD exists
        result = subprocess.run(['kubectl', 'get', 'crd', 'applications.app.k8s.io'], 
                              capture_output=True, text=True)
        if result.returncode == 0:
            print("Application CRD already exists")
            return
        
        print("Installing Application CRD...")
        subprocess.run([
            'kubectl', 'apply', '-f', 
            'https://raw.githubusercontent.com/kubernetes-sigs/application/master/config/crd/bases/app.k8s.io_applications.yaml'
        ], check=True)
        
        # Wait for CRD to be ready
        subprocess.run([
            'kubectl', 'wait', '--for=condition=established', 
            'crd/applications.app.k8s.io', '--timeout=30s'
        ], check=True)
        
        print("Application CRD installed successfully")
    except subprocess.CalledProcessError as e:
        print(f"Failed to install Application CRD: {e}")
        sys.exit(1)

if __name__ == "__main__":
    install_application_crd()