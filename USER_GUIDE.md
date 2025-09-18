# Confixa User Guide

## What is Confixa?

Confixa is a self-service DevOps platform that automates application delivery and operations. It helps teams deploy applications, monitor their health, and manage costs through a unified interface - no deep cloud-native expertise required.

**Key Benefits:**
- Automated deployments using Git workflows
- Built-in observability (metrics, logs, traces)
- AI-powered assistance for troubleshooting
- Flexible integrations with Git, Docker registries, and monitoring tools

## Deployment from Google Cloud Marketplace

### Prerequisites
- Google Cloud Project with billing enabled
- Google Kubernetes Engine (GKE) cluster
- Cluster Admin permissions
- Docker registry access (GCR recommended)
- Git repository (GitHub or Bitbucket)

### Deploy Confixa

1. **Find Confixa in Google Cloud Marketplace**
   - Go to [Google Cloud Console](https://console.cloud.google.com)
   - Navigate to Marketplace
   - Search for "Confixa"
   - Click on Confixa application

2. **Configure Deployment**
   - Select your Google Cloud Project
   - Choose your GKE cluster
   - Select namespace (or create new one)
   - Configure application settings:
     - App instance name
     - Namespace
     - Deployment parameters

3. **Deploy Application**
   - Review configuration settings
   - Click "Deploy"
   - Wait for deployment to complete (usually 3-5 minutes)

4. **Access Confixa**
   - Once deployed, go to "Applications" in GKE
   - Find your Confixa deployment
   - Click on the endpoint URL or use port-forwarding:

```bash
# Get the service details
kubectl get services -n [your-namespace]

# Port forward to access locally
**Frontend UI**
kubectl port-forward svc/confixa-frontend 5000:5000 -n [your-namespace]

**Backend API**
kubectl port-forward svc/confixa-api 5001:5001 -n [your-namespace]
```

Visit in your browser:
- Frontend: http://localhost:5000
- API: http://localhost:5001

## Getting Started

### 1. Initial Admin Setup
After accessing Confixa for the first time:
- Sign up as administrator with name, email, and password
- Log in to access the platform
- Complete the onboarding process

### 2. Onboarding Configuration

Complete these steps to configure your Confixa instance:

**Git Provider Integration**
- Connect your GitHub or Bitbucket account
- This creates a central repository for Helm charts
- Enables automated CI/CD for your services

**Organization Setup**
- Create an organization to group applications
- Set up default environments (Development, Staging, Production)
- Enable team collaboration and access controls

**AI Configuration** 
- Configure the AI chatbot for debugging assistance
- Add your OpenAI API key for enhanced AI features
- Enable automatic issue creation in your repository
- Set up code assistance for CI/CD and infrastructure snippets

**Docker Registry**
- Add your Docker registry credentials (GCR recommended for GCP)
- Enable automated image builds and deployments

**Observability**
- Configure your monitoring stack (ELK, Google Cloud Monitoring)
- Set up metrics, logging, and tracing
- Enable application performance monitoring

### 3. User Management
- New users sign up and wait for admin approval
- Admins approve users under the IAM tab
- Users can then log in and access approved resources

## Core Features

### Dashboard
Central view showing:
- Key metrics and health status
- Activity overview
- System alerts and notifications

### Projects
- Organize applications into logical groups
- Each project has its own environments and configurations
- Enables team collaboration and resource management

### Applications
- Deploy and manage applications on Kubernetes
- Automatic CI/CD pipeline integration
- Support for rollbacks and deployment strategies

### AI Chatbot
- Get assistance with troubleshooting
- Retrieve information from logs and metrics
- Receive suggested solutions for issues
- Create issues automatically when problems are detected

### Issues Management
- Track and manage problems
- AI can create issues with titles and descriptions
- Modify Helm charts through issue workflow
- Collaborate on fixes with your team

### Observability
**Metrics:** CPU, RAM, latency, throughput analysis
**Logs:** Centralized log search and filtering  
**Traces:** Service interaction and performance analysis

## Common Tasks

### Deploy an Application
1. Create or select a project
2. Connect your Git repository
3. Configure deployment settings
4. Deploy to your chosen environment
5. Monitor via the dashboard

### Monitor Application Health
1. Go to Applications section
2. Select your application
3. View metrics, logs, and traces
4. Set up alerts for critical issues

### Troubleshoot Issues
1. Use the AI chatbot to describe the problem
2. Review suggested solutions
3. Check logs and traces for root cause
4. Create issues for code/config changes if needed

### Manage Costs
1. Access cost optimization tools (Kubecost integration)
2. Review resource usage recommendations
3. Implement suggested optimizations
4. Monitor cost trends over time

## Accessing Integrated Tools

After onboarding, you may need to access integrated tools through port-forwarding:

```bash
# ArgoCD (if installed during onboarding)
kubectl port-forward svc/argocd-server 3000:443 -n [argocd-namespace]

# Kubecost (if enabled)
kubectl port-forward svc/confixa-kubecost-cost-analyzer 9090:9090 -n [namespace]

# Kubernetes Dashboard (if installed)
kubectl port-forward svc/kubernetes-dashboard 9091:443 -n [dashboard-namespace]
```

Access URLs:
- ArgoCD: http://localhost:3000
- Kubecost: http://localhost:9090  
- K8s Dashboard: http://localhost:9091

## Google Cloud Integration

### Permissions
Ensure your GKE cluster has the following permissions:
- Read/Write access to Google Container Registry
- Cloud Monitoring API access
- Cloud Logging API access

### Billing
- Confixa usage will be billed through Google Cloud Marketplace
- Monitor usage through GCP Console > Billing
- Set up billing alerts as needed

## Support

- **In-platform:** Use the Support section in Confixa
- **Email:** confixa7@gmail.com  
- **Website:** https://confixa.com/contact
- **Google Cloud Support:** Through your GCP support plan

## Common Troubleshooting

**Deployment Failed:** 
- Check GKE cluster status and permissions
- Verify billing is enabled on your GCP project
- Review deployment logs in GKE Applications section

**Access Issues:** 
- Confirm services are running: `kubectl get pods -n [namespace]`
- Check service endpoints: `kubectl get services -n [namespace]`
- Verify firewall rules allow traffic to your cluster

**Integration Problems:** 
- Verify GCP APIs are enabled (Container Registry, Monitoring, Logging)
- Check service account permissions
- Confirm Git and Docker registry credentials

**Performance Issues:** 
- Check cluster resources and scaling
- Review traces and logs in the observability section
- Monitor through Google Cloud Console

## Uninstalling

To remove Confixa:
1. Go to GKE Applications in Google Cloud Console
2. Find your Confixa deployment
3. Click "Delete"
4. Confirm deletion

Or use kubectl:
```bash
kubectl delete application [app-name] -n [namespace]
```


