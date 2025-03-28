# Confixa

![Version: 0.9.1](https://img.shields.io/badge/Version-0.9.1-informational?style=flat-square) ![AppVersion: 0.9.0-rc](https://img.shields.io/badge/AppVersion-0.9.0--rc-informational?style=flat-square)

A Helm chart that deploys confixa-with-microservices-and-dependencies

**Homepage:** <https://confixa.com>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.bitnami.com/bitnami | argocd(argo-cd) | 7.0.20 |
| https://charts.bitnami.com/bitnami | rabbitmq(rabbitmq) | 14.1.4 |
| https://charts.bitnami.com/bitnami | redis(redis) | 20.2.0 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| apiGateway.annotations.git | string | `"https://github.com/confixa/confixa-gitops.git"` |  |
| apiGateway.configMapRef | string | `"confixa-api"` |  |
| apiGateway.containerName | string | `"confixa-api"` |  |
| apiGateway.cronContainerName | string | `"confixa-api-cron"` |  |
| apiGateway.cronName | string | `"confixa-api-cron"` |  |
| apiGateway.enable | bool | `true` |  |
| apiGateway.image.pullPolicy | string | `"Always"` |  |
| apiGateway.image.repository | string | `"asia-south1-docker.pkg.dev/confixa-rnd/confixa-docker-images/dev-confixa-api"` |  |
| apiGateway.image.tag | string | `"sha-2d9385d757bef8c39c9bb4d56d7e5b8db819f8f0"` |  |
| apiGateway.name | string | `"confixa-api"` |  |
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
| argocd.enable | bool | `true` |  |
| argocd.externalRedis.existingSecret | string | `"redis-password-secret"` |  |
| argocd.externalRedis.existingSecretPasswordKey | string | `"redis-password"` |  |
| argocd.externalRedis.host | string | `"confixa-redis-master"` |  |
| argocd.externalRedis.port | int | `6379` |  |
| argocd.redis.enabled | bool | `false` |  |
| commonConfigMap | string | `"confixa-configmap"` |  |
| frontend.annotations.git | string | `"https://github.com/confixa/confixa-gitops.git"` |  |
| frontend.configMapRef | string | `"confixa-frontend"` |  |
| frontend.containerName | string | `"confixa-frontend"` |  |
| frontend.enable | bool | `true` |  |
| frontend.image.pullPolicy | string | `"Always"` |  |
| frontend.image.repository | string | `"asia-south1-docker.pkg.dev/confixa-rnd/confixa-docker-images/dev-confixa-frontend"` |  |
| frontend.image.tag | string | `"sha-5b1621cd1e46acc0b169b09dbf066a6398aa84be"` |  |
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
| llmKumaApiGateway.annotations.git | string | `"https://github.com/confixa/confixa-gitops.git"` |  |
| llmKumaApiGateway.configMapRef | string | `"confixa-llm-kuma-api"` |  |
| llmKumaApiGateway.containerName | string | `"confixa-llm-kuma-api"` |  |
| llmKumaApiGateway.enable | bool | `true` |  |
| llmKumaApiGateway.image.pullPolicy | string | `"Always"` |  |
| llmKumaApiGateway.image.repository | string | `"asia-south1-docker.pkg.dev/confixa-rnd/confixa-docker-images/dev-confixa-llm-kuma"` |  |
| llmKumaApiGateway.image.tag | string | `"sha-80b288da85180c2683f24a9dcfeb34615be05710"` |  |
| llmKumaApiGateway.name | string | `"confixa-llm-kuma-api"` |  |
| llmKumaApiGateway.ports.containerPort | int | `5002` |  |
| llmKumaApiGateway.ports.protocol | string | `"TCP"` |  |
| llmKumaApiGateway.replicas | int | `1` |  |
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

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.9.1](https://github.com/norwoodj/helm-docs/releases/v1.9.1)
