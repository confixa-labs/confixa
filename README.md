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
---

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

Use this script to bump chart versions:

```bash
./scripts/renovate-bump-version.sh confixa
```

### 🧪 CLI Usage

```bash
./cli.sh help                 # Show help
./cli.sh create-docs          # Generate Helm documentation
./cli.sh lint-charts          # Lint charts
./cli.sh bump-version         # Bump the chart version
./cli.sh next-version-branch  # Create next version branch
```

### 🚀 Release Helper

```bash
# Create a minor release and PR with message and release notes
./release.sh -t minor -m "New feature release" -b develop -n release-notes.md -r -p beta

# Finalize release by removing postfix
./release.sh -m "Release version" -r

# Trigger releases by type
./release.sh -t minor -m "New feature release" -r
./release.sh -t major -m "Major version release" -r
./release.sh -t patch -m "Patch release" -r
```
---

## 🌐 Community

We’re passionate about growing a strong and collaborative community around Confixa.

Stay connected, get support, and collaborate with us through our community channels:

- **Twitter**: [@ConfixaPlatform](https://twitter.com/@confixa7) — for announcements and quick updates
- **Instagram**: [@ConfixaPlatform](https://instagram.com/ConfixaPlatform) — for stories, tips, and a glimpse behind the scenes
- **Discord**: [Confixa Community](https://discord.gg/Sn8XM6NHTs) — for real-time collaboration, Q&A, and networking
- **YouTube**: [Confixa Channel](https://youtube.com/@confixa) — for demos, webinars, and technical walkthroughs

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