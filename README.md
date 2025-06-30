<p align="center">
  <img src="https://storage.googleapis.com/confixa-files/logo-text.png" alt="Confixa Logo" height="100" />
</p>

<div align="center">

[![Discord](https://img.shields.io/badge/Discord-Join-blue?logo=discord)](https://discord.gg/Sn8XM6NHTs)
[![Docs](https://img.shields.io/badge/Docs-Explore-blue)](https://docs.confixa.com)
[![Website](https://img.shields.io/badge/Website-Visit-blue)](https://www.confixa.com)
[![Artifact Hub](https://img.shields.io/badge/Artifact%20Hub-View-blue?logo=kubernetes)](https://artifacthub.io/packages/helm/confixa/confixa)
[![Contributors](https://img.shields.io/badge/Contributors-View-blue)](./CONTRIBUTORS.md)
[![License](https://img.shields.io/badge/License-MIT-blue)](./LICENSE)

</div>

<!-- [![Release](https://img.shields.io/badge/Release-Latest-blue)](https://github.com/your-user/your-repo/releases) -->

## 🧭 Overview

Confixa is a **self-service platform** designed to empower growing companies and enterprise teams by simplifying application delivery and operations.  
It provides a unified interface to:

- Connect code repositories
- Deploy applications to clusters
- Track application health
- Automate responses to incidents
- Optimize cost management

With Confixa, your team can move faster — without requiring deep DevOps expertise.

---

## ❗ Problem Statement

Today’s application delivery landscape is fragmented and complex:

- Too many tools with overlapping features
- Manual deployments and repetitive operations
- Slow incident response due to lack of visibility
- Growing operational overhead as teams scale

---

## ✅ Solution

Confixa offers a **centralized and intuitive platform** that:

- Integrates delivery orchestration, monitoring, and automation
- Provides real-time insights into application health
- Enables self-service operations for development teams
- Reduces manual errors and accelerates deployment cycles

---

## ✨ Features

- 🚀 Continuous Delivery & Operations

  Streamline your delivery pipeline from code repository to production.
- 🖱️ One-Click Deployments

  Easily deploy new services or update existing ones with confidence.
- 📊 Centralized Health Monitoring  

  Monitor service health, track performance metrics, and respond quickly to problems.
- ⚙️ Automated Operations

  Reduce manual workloads with automated routines and routines that aid operational stability.
- 📈 Scalable Collaboration

  Support growing team sizes and growing workloads without bottlenecks.
- 📝 Audit & Traceability

  Keep a clear record of all delivery and operational events for compliance and future analysis.

---

## 🧪 Getting Started

This repository contains [Helm](https://helm.sh/) charts for deploying Confixa.

### 📦 Installation Instructions

1. Add Helm Repository
    ```bash
     helm repo add confixa https://confixa-labs.github.io/confixa/charts
     helm repo update
    ```
2. Install the Chart
    ```bash
     helm install confixa confixa/Confixa --version 0.9.1
    ```
3. Upgrade the Chart
    ```bash
     helm repo update
     helm upgrade confixa confixa/Confixa --version 0.9.1
    ```
4. Uninstall the Chart

    To uninstall the chart from your Kubernetes cluster, use the following command:
    ```bash
     helm uninstall confixa --namespace confixa
    ```
    This will remove all the resources created by the chart in the specified namespace. If you no longer need the namespace, you can delete it as well:
    ```bash
     kubectl delete namespace confixa
    ```
5. Port Forwarding for Browser Access

    ### Initial Access (Post Installation)

    After installing Confixa via Helm, you can port-forward the frontend and API services for local access in the browser.

    **Namespace**: Replace `confixa-namespace` with the namespace you used during installation.

    ``` bash
    # Frontend UI
    kubectl port-forward svc/confixa-frontend 5000:5000 -n confixa-namespace

    # Backend API
    kubectl port-forward svc/confixa-api 5001:5001 -n confixa-namespace
    ```

    **Access in browser**:

    - [http://localhost:5000](http://localhost:5000) – Confixa Frontend
    - [http://localhost:5001](http://localhost:5001) – Confixa API

    ---

    ### Access After Onboarding

    If additional services were installed during onboarding (or exist from previous installations), you can access them by forwarding the respective ports.

    #### Argo CD

    ```bash
    kubectl port-forward svc/argocd-server 3000:443 -n <argocd-namespace>
    ```

    > Default namespace: `argocd`

    **Access:** [http://localhost:3000](http://localhost:3000)

    ---

    #### Kubecost (Cost Analyzer)

    ```bash
    kubectl port-forward svc/confixa-kubecost-cost-analyzer 9090:9090 -n <kubecost-namespace>
    ```

    **Access:** [http://localhost:9090](http://localhost:9090)

    ---

    #### Kubernetes Dashboard

    ```bash
    kubectl port-forward svc/kubernetes-dashboard 9091:443 -n <dashboard-namespace>
    ```

    **Access:** [http://localhost:9091](http://localhost:9091)

    ---

    > Replace `<argocd-namespace>`, `<kubecost-namespace>`, and `<dashboard-namespace>` with the actual namespaces where each service is installed. These may have been created during onboarding or may already exist in your cluster.

    ---

    ### Notes
    ---
    You can also navigate via your Kubernetes dashboard (e.g., Lens or K9s):

    - Open the **Services** section.
    - Locate the desired service (e.g., `confixa-frontend`, `argocd-server`, etc.).
    - Use the **"Port Forward"** feature to access the UI without using the CLI.

## 🛠️ Developer Setup

### 🚀 Local Kubernetes with Minikube

Start Minikube:

```bash
minikube start
# or with custom resources
minikube start --cpus=2 --memory=4096 --driver=docker
```

### ⚙️ Helm Chart Usage (Local Development)

Navigate to the `helm` directory and build dependencies:

```bash
cd charts/helm
helm dependency build
```

In the `charts` directory:

```bash
cd ..
# Clean old index and package files if they exist
rm -f index.yaml *.tgz

# Create a Helm package
helm package helm -d .

# Create the repository index
helm repo index .
```

Return to the `helm` directory to update dependencies:

```bash
cd helm
helm dependency update
```

Install or upgrade the chart:

```bash
helm upgrade confixa . --namespace confixa-test --install --create-namespace
```

Uninstall and clean up the chart:

```bash
helm uninstall confixa --namespace confixa-test
kubectl delete namespace confixa-test
```

### ✅ Pre-commit Hooks

Make sure [pre-commit](https://pre-commit.com/) is installed:

```bash
# Using pip
pip install pre-commit

# Or using Homebrew
brew install pre-commit
```

Install the hooks:

```bash
pre-commit install
```

Run all hooks manually:

```bash
pre-commit run --all-files
```

Ensure script executables are properly set:

```bash
chmod +x cli.sh
chmod +x scripts/*.sh
```

Test with a commit:

```bash
git commit -m "Test pre-commit hook"
```

### 🔁 Version Bump (Renovate)

To bump Helm chart versions, run the script from the root directory:

```bash
./scripts/renovate-bump-version.sh helm
```

### 🧪 CLI Usage

Run the following commands from the root level of the repository:

```bash
./cli.sh help                 # Show help
./cli.sh create-docs          # Generate Helm documentation
./cli.sh lint-charts          # Lint charts
./cli.sh bump-version         # Bump the chart version
./cli.sh next-version-branch  # Create next version branch
```

These scripts streamline Helm chart maintenance tasks such as linting, versioning, and documentation.

### 🚀 Release Helper

Run the following scripts from the root level of the repository to manage and automate Helm chart releases:

```bash
# Create a minor release and PR with message and release notes
./scripts/release.sh -t minor -m "New feature release" -b develop -n release-notes.md -r -p beta

# Finalize release by removing postfix
./scripts/release.sh -m "Release version" -r

# Trigger releases by type
./scripts/release.sh -t minor -m "New feature release" -r
./scripts/release.sh -t major -m "Major version release" -r
./scripts/release.sh -t patch -m "Patch release" -r
```

These commands automate versioning, changelog generation, and branching during your release lifecycle.

---

## 🌐 Community

We’re passionate about growing a strong and collaborative community around Confixa.

Stay connected, get support, and collaborate with us through our community channels:

- **Twitter**: [Platform](https://twitter.com/@confixa7) — for announcements and quick updates
- **Instagram**: [Platform](https://instagram.com/ConfixaPlatform) — for stories, tips, and a glimpse behind the scenes
- **Discord**: [Community](https://discord.gg/Sn8XM6NHTs) — for real-time collaboration, Q&A, and networking
- **YouTube**: [Channel](https://youtube.com/@confixa7) — for demos, webinars, and technical walkthroughs

---

## 🤝 Contribute

We welcome all contributors — developers, designers, writers, testers, and curious minds!

### How to Contribute

1. Fork this repository  
2. Create a new branch with your feature or bug fix.
3. Submit a Pull Request with a clear description of your change.
4. Collaborate and respond to reviews from our team.

Thank you for helping make Confixa a powerful platform for everyone.

---

## 👥 Contributors

Confixa’s contributors come from a range of backgrounds — engineers, designers, technical writers, and community members. We appreciate their continued efforts and passion for making Confixa better.

Thanks to all our amazing contributors who make this project possible!

👉 See [CONTRIBUTORS.md](./CONTRIBUTORS.md) for the full list.

---

## 🔒 Vulnerability Reporting

Security is a top priority for Confixa.
If you discover a vulnerability, please report it privately and responsibly to:

📧 [confixa7@gmail.com](mailto:confixa7@gmail.com)

We appreciate your discretion and your help in keeping Confixa safe for everyone.

---

## 📜 License

Confixa is licensed under the [MIT License](./LICENSE).