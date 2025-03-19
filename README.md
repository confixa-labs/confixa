# Confixa Helm Chart

[![License](https://img.shields.io/badge/license-Private%20Use-blue)](./LICENSE)

This repository contains [Helm](https://helm.sh/) charts for Confixa project.

- [Confixa Helm Chart](#confixa-helm-chart)
  - [Usage](#usage)
  - [pre-commit hooks](#pre-commit-hooks)
  - [Renovate Bump Version](#renovate-bump-version)
  - [Installing/Upgrading Chart for testing](#installingupgrading-chart-for-testing)
  - [Removing the Chart](#removing-the-chart)
  - [CLI usage](#cli-usage)
  - [License](#license)

## Usage

[Helm](https://helm.sh/) must be installed to use the charts. Please refer to Helm's [documentation](https://helm.sh/docs/) to get started.

Once Helm is set up properly, add the repo as follows:

```bash
helm repo add confixa https://github.com/confixa/confixa-helm
```

## pre-commit hooks

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

## Renovate Bump Version

```bash
./scripts/renovate-bump-version.sh confixa
```

## Installing/Upgrading Chart for testing

```bash
helm upgrade confixa . --namespace confixa --install --create-namespace
```

## Removing the Chart

To uninstall the chart from your Kubernetes cluster, use the following command:

```bash
helm uninstall confixa --namespace confixa
```

This will remove all the resources created by the chart in the specified namespace. If you no longer need the namespace, you can delete it as well:

```bash
kubectl delete namespace confixa
```

## CLI usage

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

## License

This Helm chart is licensed under the **Private Use License for Helm Charts** by Wohlig Transformation Pvt. Ltd.

- Usage is restricted to personal evaluation and deploying Confixa.
- Modifications, redistribution, or unauthorized use are strictly prohibited.

For detailed terms, see the [LICENSE](./LICENSE) file.

For permissions beyond the scope of this license, contact us at [contact@confixa.com](mailto:contact@confixa.com).
