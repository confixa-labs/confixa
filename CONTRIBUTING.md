
# 🤝 Contributing to Confixa Charts

Thank you for your interest in contributing to the Confixa charts!  
We welcome all contributions — whether it’s fixing bugs, improving documentation, adding features, or enhancing chart quality.

This repository contains official [Helm](https://helm.sh) charts for deploying [Confixa](https://www.confixa.com) on Kubernetes.  
We follow Helm best practices to maintain reusable, secure, and versioned charts.

---

## 🛠 Quick Developer Setup

```bash
# Start a local cluster
minikube start --cpus=2 --memory=4096 --driver=docker

# Install pre-commit and initialize hooks
pip install pre-commit && pre-commit install

# Make scripts executable
chmod +x cli.sh scripts/*.sh

# Build and update chart dependencies
cd helm && helm dependency build && helm dependency update

# Package and index charts
cd ../charts
rm -f index.yaml *.tgz
helm package ../helm -d .
helm repo index .

# Install or upgrade locally
helm upgrade confixa . --namespace confixa-test --install --create-namespace

# To uninstall and clean up
helm uninstall confixa --namespace confixa-test
kubectl delete namespace confixa-test
```

---

## ✅ Submitting a Pull Request

We use GitHub pull requests for all changes. All submissions require code review and must meet the following criteria:

- Helm chart installs without error
- Changes are tested and documented
- Pre-commit hooks and lint checks pass

### 🔖 PR Title Linting

We follow [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) for pull request titles.  
PR titles should include a scope — typically the chart name. Example:

```bash
fix(confixa-app): fix typo in values.yaml
```

---

## 🧾 Versioning

All charts follow [Semantic Versioning](https://semver.org/).

- **Major** — Breaking or destructive changes
- **Minor** — Feature additions, major app updates
- **Patch** — Backward-compatible fixes, minor app bumps

To bump the chart version:

```bash
./scripts/renovate-bump-version.sh confixa
```

> Chart versions must be immutable. Any change (even docs) must increment the chart version.

---

## 📚 Documentation

Each chart includes auto-generated documentation using [helm-docs](https://github.com/norwoodj/helm-docs).

To regenerate docs after editing `README.md.gotmpl`:

```bash
./scripts/helm-docs.sh
```

Don’t manually edit `README.md` — it’s overwritten by the script.

---

## 🧪 Testing

### Linting Charts

We use [helm/chart-testing](https://github.com/helm/chart-testing) with stricter validation.

Manually lint charts with:

```bash
./scripts/lint.sh
```

### Installing for Validation

```bash
helm install charts/confixa-app -n confixa
```

Check that the application deploys and services respond as expected.

---

## 📝 Artifact Hub Annotations

To publish properly on [Artifact Hub](https://artifacthub.io):

- Add `artifacthub.io/changes` in the `annotations` of `Chart.yaml`
- Example:

```yaml
annotations:
  artifacthub.io/changes: |
    - kind: added
      description: Added Redis support
    - kind: fixed
      description: Fixed secret rendering issue
```

---

## 🔁 Chart Release Automation

Merges into `main` automatically trigger chart publication via GitHub Actions (`.github/workflows/publish.yml`).

Make sure:
- Chart version is bumped
- Changes are documented in `Chart.yaml` annotations

---

## 🙋 Need Help?

- 💬 [Discord](https://discord.gg/Sn8XM6NHTs)
- 📧 [confixa7@gmail.com](mailto:confixa7@gmail.com)

---

## 📜 Code of Conduct

Please review our [CODE_OF_CONDUCT.md](./CODE_OF_CONDUCT.md).  
By participating, you agree to uphold our community standards.

---

Thanks for making Confixa better 💙
