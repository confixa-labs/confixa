# Confixa

![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square) ![AppVersion: 1.0.0](https://img.shields.io/badge/AppVersion-1.0.0-informational?style=flat-square)

A Helm chart that deploys confixa-with-microservices-and-dependencies

**Homepage:** <https://confixa.com>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.bitnami.com/bitnami | rabbitmq(rabbitmq) | 14.1.4 |
| https://charts.bitnami.com/bitnami | redis(redis) | 20.2.0 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| apiGateway.annotations.git | string | `"https://github.com/confixa-labs/confixa.git"` |  |
| apiGateway.argoCdCheckStatus.containerName | string | `"confixa-argocd-check-status"` |  |
| apiGateway.argoCdCheckStatus.enable | bool | `true` |  |
| apiGateway.argoCdCheckStatus.name | string | `"confixa-argocd-check-status"` |  |
| apiGateway.bitbucketOauthToken.containerName | string | `"confixa-bitbucket-oauth-token"` |  |
| apiGateway.bitbucketOauthToken.enable | bool | `true` |  |
| apiGateway.bitbucketOauthToken.name | string | `"confixa-bitbucket-oauth-token"` |  |
| apiGateway.configMapRef | string | `"confixa-api"` |  |
| apiGateway.containerName | string | `"confixa-api"` |  |
| apiGateway.enable | bool | `true` |  |
| apiGateway.evenSlug.containerName | string | `"confixa-even-slug"` |  |
| apiGateway.evenSlug.enable | bool | `true` |  |
| apiGateway.evenSlug.name | string | `"confixa-even-slug"` |  |
| apiGateway.image.pullPolicy | string | `"Always"` |  |
| apiGateway.image.repository | string | `"asia-south1-docker.pkg.dev/confixa-rnd/confixa-docker-images/dev-confixa-api"` |  |
| apiGateway.image.tag | string | `"sha-502e2749530f8e184032f38b04b9d1f5020ca0b4"` |  |
| apiGateway.issueCron.containerName | string | `"confixa-issue-cron"` |  |
| apiGateway.issueCron.enable | bool | `true` |  |
| apiGateway.issueCron.name | string | `"confixa-issue-cron"` |  |
| apiGateway.monitorCleaner.containerName | string | `"confixa-monitor-cleaner"` |  |
| apiGateway.monitorCleaner.enable | bool | `true` |  |
| apiGateway.monitorCleaner.name | string | `"confixa-monitor-cleaner"` |  |
| apiGateway.name | string | `"confixa-api"` |  |
| apiGateway.oddSlug.containerName | string | `"confixa-odd-slug"` |  |
| apiGateway.oddSlug.enable | bool | `true` |  |
| apiGateway.oddSlug.name | string | `"confixa-odd-slug"` |  |
| apiGateway.ports.containerPort | int | `5001` |  |
| apiGateway.ports.protocol | string | `"TCP"` |  |
| apiGateway.replicas | int | `1` |  |
| apiGateway.resources.limits.cpu | string | `"750m"` |  |
| apiGateway.resources.limits.memory | string | `"1024Mi"` |  |
| apiGateway.resources.requests.cpu | string | `"100m"` |  |
| apiGateway.resources.requests.memory | string | `"128Mi"` |  |
| apiGateway.service.port | int | `80` |  |
| apiGateway.service.protocol | string | `"TCP"` |  |
| apiGateway.service.targetPort | int | `5001` |  |
| apiGateway.service.type | string | `"ClusterIP"` |  |
| appName | string | `"confixa"` |  |
| commonConfigMap | string | `"confixa-configmap"` |  |
| frontend.annotations.git | string | `"https://github.com/confixa-labs/confixa.git"` |  |
| frontend.configMapRef | string | `"confixa-frontend"` |  |
| frontend.containerName | string | `"confixa-frontend"` |  |
| frontend.enable | bool | `true` |  |
| frontend.image.pullPolicy | string | `"Always"` |  |
| frontend.image.repository | string | `"asia-south1-docker.pkg.dev/confixa-rnd/confixa-docker-images/dev-confixa-frontend"` |  |
| frontend.image.tag | string | `"sha-4800c38d4e14c2a28a8e9ca17c878cf1c07affab"` |  |
| frontend.name | string | `"confixa-frontend"` |  |
| frontend.ports.containerPort | int | `5000` |  |
| frontend.ports.protocol | string | `"TCP"` |  |
| frontend.replicas | int | `1` |  |
| frontend.resources.limits.cpu | string | `"500m"` |  |
| frontend.resources.limits.memory | string | `"512Mi"` |  |
| frontend.resources.requests.cpu | string | `"100m"` |  |
| frontend.resources.requests.memory | string | `"128Mi"` |  |
| frontend.service.port | int | `80` |  |
| frontend.service.protocol | string | `"TCP"` |  |
| frontend.service.targetPort | int | `5000` |  |
| frontend.service.type | string | `"ClusterIP"` |  |
| llmKumaApiGateway.annotations.git | string | `"https://github.com/confixa-labs/confixa.git"` |  |
| llmKumaApiGateway.configMapRef | string | `"confixa-llm-kuma-api"` |  |
| llmKumaApiGateway.containerName | string | `"confixa-llm-kuma-api"` |  |
| llmKumaApiGateway.enable | bool | `true` |  |
| llmKumaApiGateway.image.pullPolicy | string | `"Always"` |  |
| llmKumaApiGateway.image.repository | string | `"asia-south1-docker.pkg.dev/confixa-rnd/confixa-docker-images/dev-confixa-llm-kuma"` |  |
| llmKumaApiGateway.image.tag | string | `"sha-1b9f8fab28e2661a266040d699afd181caaf85bb"` |  |
| llmKumaApiGateway.name | string | `"confixa-llm-kuma-api"` |  |
| llmKumaApiGateway.ports.containerPort | int | `5002` |  |
| llmKumaApiGateway.ports.protocol | string | `"TCP"` |  |
| llmKumaApiGateway.replicas | int | `1` |  |
| llmKumaApiGateway.service.name | string | `"confixa-llm-kuma-api"` |  |
| llmKumaApiGateway.service.port | int | `80` |  |
| llmKumaApiGateway.service.protocol | string | `"TCP"` |  |
| llmKumaApiGateway.service.targetPort | int | `5002` |  |
| llmKumaApiGateway.service.type | string | `"ClusterIP"` |  |
| mongodb.affinity | object | `{}` |  |
| mongodb.auth.databases[0] | string | `"confixa"` |  |
| mongodb.auth.passwords[0] | string | `"Sm2dnl23dwe7lerPDD"` |  |
| mongodb.auth.rootDatabase | string | `"confixa"` |  |
| mongodb.auth.rootUser | string | `"root"` |  |
| mongodb.auth.usernames[0] | string | `"confixa-admin"` |  |
| mongodb.containerName | string | `"confixa-mongodb"` |  |
| mongodb.enable | bool | `true` |  |
| mongodb.image.pullPolicy | string | `"IfNotPresent"` |  |
| mongodb.image.repository | string | `"mongo"` |  |
| mongodb.image.tag | string | `"8.0.5"` |  |
| mongodb.name | string | `"confixa-mongodb"` |  |
| mongodb.nodeSelector | object | `{}` |  |
| mongodb.persistence.enabled | bool | `true` |  |
| mongodb.persistence.size | string | `"8Gi"` |  |
| mongodb.resources | object | `{}` |  |
| mongodb.service.name | string | `"confixa-mongodb"` |  |
| mongodb.service.port | int | `27017` |  |
| mongodb.service.type | string | `"ClusterIP"` |  |
| mongodb.tolerations | list | `[]` |  |
| passwordRabbitMQSecretsManagerName | string | `"rabbitmq-password-secret"` |  |
| passwordRedisSecretsManagerName | string | `"redis-password-secret"` |  |
| passwordSecretsManagerName | string | `"confixa-passwords-secret"` |  |
| rabbitmq.auth.existingPasswordSecret | string | `"rabbitmq-password-secret"` |  |
| rabbitmq.auth.username | string | `"admin"` |  |
| rabbitmq.enable | bool | `true` |  |
| rabbitmq.service.name | string | `"confixa-rabbitmq"` |  |
| redis.auth.enabled | bool | `true` |  |
| redis.auth.existingSecret | string | `"redis-password-secret"` |  |
| redis.enable | bool | `true` |  |
| redis.master.nodeSelector | object | `{}` |  |
| redis.replica.nodeSelector | object | `{}` |  |
| redis.replica.replicaCount | int | `1` |  |
| redis.service.name | string | `"confixa-redis-master"` |  |
| service.url.argocd | string | `"http://localhost:3000"` |  |
| service.url.backend | string | `"http://localhost:5001"` |  |
| service.url.clusterDashboard | string | `"http://localhost:9091"` |  |
| service.url.frontend | string | `"http://localhost:5000"` |  |
| service.url.kubeCost | string | `"http://localhost:9090"` |  |
| watcher.annotations.git | string | `"https://github.com/confixa-labs/confixa.git"` |  |
| watcher.containerName | string | `"confixa-watcher"` |  |
| watcher.docker.dockerRef | string | `"docker-socket"` |  |
| watcher.docker.dockerType | string | `"Socket"` |  |
| watcher.docker.mountPath | string | `"/var/run/docker.sock"` |  |
| watcher.enable | bool | `false` |  |
| watcher.image.repository | string | `"asia-south1-docker.pkg.dev/confixa-rnd/custom-runner/configmap-updates-watcher"` |  |
| watcher.image.tag | string | `"sha-1d2d767afc82565a5f7278d7dd92c5a919a763ce"` |  |
| watcher.name | string | `"confixa-watcher"` |  |
| watcher.replicas | int | `1` |  |
| watcher.role.roleRef | string | `"confixa-watcher-role"` |  |
| watcher.roleBinding.roleBindingRef | string | `"confixa-watcher-role-binding"` |  |
| watcher.secret.file.mountPath | string | `"/mnt/secrets"` |  |
| watcher.secret.file.secretInfo | string | `"{key:\"value\"}"` |  |
| watcher.secret.secretRef.file | string | `"confixa-watcher"` |  |
| watcher.secret.secretRef.variables | string | `"confixa-watcher-variables"` |  |
| watcher.secret.variables.branch | string | `"uat"` |  |
| watcher.secret.variables.configMapName | string | `"confixa-frontend"` |  |
| watcher.secret.variables.containerName | string | `"confixa-frontend"` |  |
| watcher.secret.variables.customExec | string | `"true"` |  |
| watcher.secret.variables.deploymentName | string | `"confixa-frontend"` |  |
| watcher.secret.variables.dockerImageName | string | `"custom-runner/public-build"` |  |
| watcher.secret.variables.dockerRegion | string | `"asia-south1-docker.pkg.dev"` |  |
| watcher.secret.variables.execPath | string | `"/app/frontend-update.sh"` |  |
| watcher.secret.variables.gcrProjectId | string | `"confixa-rnd"` |  |
| watcher.secret.variables.namespace | string | `"backend"` |  |
| watcher.secret.variables.repoUrl | string | `"https://github.com/confixa-labs/Confixa-FrontEnd.git"` |  |
| watcher.secret.variables.serviceAccountKeyPath | string | `"/tmp/service-account.json"` |  |
| watcher.serviceAccount.serviceAccountRef | string | `"confixa-configmap-watcher"` |  |
| watcher.serviceAccount.volumeRef | string | `"confixa-watcher-volume"` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.9.1](https://github.com/norwoodj/helm-docs/releases/v1.9.1)
