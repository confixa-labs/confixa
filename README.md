# Confixa

<!-- project overview, problem statement, solution, features, getting started, and links. -->
 <!-- Include links to CONTRIBUTING.md, Code of Conduct, and License. -->

[![Discord](https://img.shields.io/badge/Discord-Join-blue?logo=discord)](https://discord.gg/your-server)
[![License](https://img.shields.io/badge/License-MIT-blue)](./LICENSE)
[![Artifact Hub](https://img.shields.io/badge/Artifact%20Hub-View-blue?logo=kubernetes)](https://artifacthub.io/packages/helm/confixa/confixa)
[![Contributors](https://img.shields.io/badge/Contributors-View-blue)](./CONTRIBUTORS.md)
[![Release](https://img.shields.io/badge/Release-Latest-blue)](https://github.com/your-user/your-repo/releases)
[![Website](https://img.shields.io/badge/Website-Visit-blue)](https://www.confixa.com)
[![Explore Documentation](https://img.shields.io/badge/Docs-Explore-blue)](https://docs.confixa.com)

## Project Overview

Confixa is a self-service platform designed to enable growing companies and enterprise teams to streamline their delivery pipeline, connect their code repositories, deploy to clusters, track application health, respond to issues faster, and manage their costs — all through a unified platform with an easy-to-understand UI.

Confixa’s mission is to empower your team to move faster and more safely, without requiring deep expertise in operations, scripting, or complex tool chains.

## Problem Statement

Managing delivery, operations, and scaling applications can be challenging — especially for growing companies. Often, there’s a confusing array of separate tools, incomplete visibility into application health, and bottlenecks that slow down delivery. This results in delayed deployments, poor incident response, and growing operational overhead.

## Solution

Confixa solves these problems by providing a unified platform that brings together delivery orchestration, operational automation, and real-time observability — all within a single, easy-to-understand UI.
This lets your team collaborate more efficiently, respond faster to issues, and accelerate delivery without needing extensive scripting or specialized expertise.

## Features

- Continuous Delivery and Operations — Streamline your delivery pipeline from code repository to production.
- One-Click Deployments — Easily deploy new services or update existing ones with confidence.
- Centralized Application Health View — Monitor service health, track performance metrics, and respond quickly to problems.
- Automated Operations — Reduce manual workloads with automated routines and routines that aid operational stability.
- Scalable and Collaborative — Support growing team sizes and growing workloads without bottlenecks.
- Audit and Traceability — Keep a clear record of all delivery and operational events for compliance and future analysis.

## Getting Started
<!-- [![License](https://img.shields.io/badge/license-Private%20Use-blue)](./LICENSE) -->

This repository contains [Helm](https://helm.sh/) charts for Confixa project.

- [Usage](#usage)
- [pre-commit hooks](#pre-commit-hooks)
- [Renovate Bump Version](#renovate-bump-version)
- [Installing/Upgrading Chart for testing](#installingupgrading-chart-for-testing)
- [Removing the Chart](#removing-the-chart)
- [CLI usage](#cli-usage)

### Usage

[Helm](https://helm.sh/) must be installed to use the charts. Please refer to Helm's [documentation](https://helm.sh/docs/) to get started.

Once Helm is set up properly, add the repo as follows:

```bash
helm repo add confixa https://confixa.github.io/confixa-helm/charts
```

### pre-commit hooks

First, ensure you have the pre-commit tool installed. You can install it globally via pip (Python package manager):

```bash
pip install pre-commit
```

Alternatively, you can install it using Homebrew (macOS):

```bash
brew install pre-commit
```

After creating the .pre-commit-config.yaml file, you need to install the hooks defined in it:

```bash
pre-commit install
```

This will install the hooks defined in your configuration and enable them for every commit.

If you want to run the hooks manually (for example, before committing), you can use:

```bash
pre-commit run --all-files
```

Make sure that both ./scripts/helm-docs.sh and ./scripts/lint.sh are executable. You can do this by running:

```bash
chmod +x cli.sh
chmod +x scripts/*.sh
```

Now, every time you attempt to make a commit, the pre-commit hooks will run, ensuring the linting and documentation generation is done before the commit is finalized.

```bash
git commit -m "Test pre-commit hook"
```

This will run all the hooks on all files in your repository.

### Renovate Bump Version

```bash
./scripts/renovate-bump-version.sh confixa
```

### Installing/Upgrading Chart for testing

Installing Chart

```bash
helm install confixa confixa/Confixa --version 0.9.1
```

Upgrading Chart

```bash
helm repo update
helm upgrade confixa confixa/Confixa --version 0.9.1
```

### Removing the Chart

To uninstall the chart from your Kubernetes cluster, use the following command:

```bash
helm uninstall confixa --namespace confixa
```

This will remove all the resources created by the chart in the specified namespace. If you no longer need the namespace, you can delete it as well:

```bash
kubectl delete namespace confixa
```

### CLI usage

```bash
# Show help
./cli.sh help

# Generate documentation
./cli.sh create-docs

# Lint charts
./cli.sh lint-charts

# Bump version
./cli.sh bump-version

# Create Next Version Branch
./cli.sh next-version-branch

# Create release and versioning manage
./release.sh -t minor -m 'New feature release' -b develop -n release-notes.md -r -p beta"
./release.sh -m 'Release version' -r  # Removes postfix and creates release"

# This will create a PR (removes postfix and creates release)
./release.sh -m "Release version" -r
# These will not remove any postfixes added to the branch name as release
./release.sh -t minor -m "New feature release" -r
./release.sh -t major -m "Major version release" -r
./release.sh -t patch -m "Patch release" -r
```

## Community

We’re passionate about growing a strong and collaborative community around Confixa. \
Stay connected, get support, and collaborate with us through our community channels:

- Twitter: @ConfixaPlatform — for announcements and quick updates
- Instagram: @ConfixaPlatform — for stories, tips, and a glimpse behind the scenes
- Discord: Confixa Community — for real-time collaboration, Q&A, and networking
- YouTube: Confixa Channel — for demos, webinars, and technical walkthroughs

## Contribute

Confixa is open-source and community-driven — we welcome contributors from all backgrounds!
Whether you’re a coder, designer, technical writer, or enthusiastic user, there’s a way you can make Confixa even better.

To contribute:
	1.	Fork this repository.
	2.	Create a new branch with your feature or bug fix.
	3.	Submit a Pull Request with a clear description of your change.
	4.	Collaborate and respond to reviews from our team.

Thank you for helping make Confixa a powerful platform for everyone.

### Contributors:

Confixa’s contributors come from a range of backgrounds — engineers, designers, technical writers, and community members.
We appreciate their continued efforts and passion for making Confixa better.

See CONTRIBUTORS.md for a complete list of contributors.

## Vulnerability Reporting

Security is a top priority for Confixa.
If you discover a vulnerability, please report it responsibly to:

[contact@confixa.com](mailto:contact@confixa.com)

We appreciate your discretion and help in keeping Confixa safe for everyone.

## License

Confixa is licensed under MIT License.\
See the LICENSE file for details.

