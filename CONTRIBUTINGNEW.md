
# 🤝 Contributing to Confixa Helm Charts

Thank you for your interest in contributing to the Confixa Helm charts!  
We welcome all contributions — whether it’s fixing bugs, improving documentation, adding features, or enhancing chart quality.

---

## 📦 About This Repo

This repository contains the official [Helm](https://helm.sh/) charts for deploying [Confixa](https://www.confixa.com) on Kubernetes.  
We follow Helm best practices and maintain reusable, secure, and versioned charts.

---

## 🛠 Prerequisites

- Helm ≥ 3.7
- Kubernetes cluster (e.g. via `minikube`, `kind`, or cloud)
- [`pre-commit`](https://pre-commit.com/) installed
- Basic Git and CLI knowledge

---

## ⚙️ Setup for Development

1. Fork and clone the repo:
   ```bash
   git clone https://github.com/your-username/confixa-helm.git
   cd confixa-helm
   ```

2. Install pre-commit hooks:
   ```bash
   pip install pre-commit
   pre-commit install
   ```

3. Make the necessary scripts executable:
   ```bash
   chmod +x cli.sh
   chmod +x scripts/*.sh
   ```

4. (Optional) Start a local cluster:
   ```bash
   minikube start --cpus=2 --memory=4096 --driver=docker
   ```

---

## 🧪 Chart Testing & Linting

Run the following commands before submitting a PR:

```bash
./cli.sh lint-charts        # Lint Helm charts
./cli.sh create-docs        # Generate README.md from Chart.yaml
./scripts/lint.sh           # Additional YAML schema checks
```

---

## 🚀 Helm Chart Build Instructions

1. Build dependencies:
   ```bash
   cd helm
   helm dependency build
   helm dependency update
   ```

2. Package & index charts (inside `charts/`):
   ```bash
   helm package ../helm -d .
   helm repo index .
   ```

3. Install locally:
   ```bash
   helm upgrade confixa . --namespace confixa-test --install --create-namespace
   ```

4. Uninstall:
   ```bash
   helm uninstall confixa --namespace confixa-test
   kubectl delete namespace confixa-test
   ```

---

## 🧾 Versioning

Chart versions follow [semver](https://semver.org/).  
To bump the version (used by Renovate):

```bash
./scripts/renovate-bump-version.sh confixa
```

---

## ✅ Submitting a Pull Request

1. Create a feature branch:
   ```bash
   git checkout -b fix/your-feature-name
   ```

2. Make your changes and commit:
   ```bash
   git commit -am "fix(chart): describe your update"
   ```

3. Push and open a PR:
   ```bash
   git push origin fix/your-feature-name
   ```

Please ensure:
- Your chart installs cleanly
- Documentation is updated
- Tests/linting pass

---

## 📚 Documentation

All chart documentation is auto-generated using:
```bash
./cli.sh create-docs
```

Ensure your `Chart.yaml`, `values.yaml`, and any templates are annotated appropriately.

---

## 🙋 Need Help?

Join our [Discord Community](https://discord.gg/your-server)  
or reach us at [contact@confixa.com](mailto:contact@confixa.com)

---

## 📜 Code of Conduct

Please note that this project is released with a [Code of Conduct](../CODE_OF_CONDUCT.md).  
By participating, you agree to abide by its terms.

---

Thank you for contributing to Confixa Helm! 💙
