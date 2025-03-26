# Confixa

![Version: 0.9.1](https://img.shields.io/badge/Version-0.9.1-informational?style=flat-square) ![AppVersion: 0.9.0-rc](https://img.shields.io/badge/AppVersion-0.9.0--rc-informational?style=flat-square)

A Helm chart that deploys confixa-with-microservices-and-dependencies

**Homepage:** <https://confixa.com>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.bitnami.com/bitnami | argocd(argo-cd) | 7.0.20 |
| https://charts.bitnami.com/bitnami | contour(contour) | 19.4.0 |
| https://charts.bitnami.com/bitnami | rabbitmq(rabbitmq) | 14.1.4 |
| https://charts.bitnami.com/bitnami | redis(redis) | 20.2.0 |
| https://dirsigler.github.io/uptime-kuma-helm | uptimekuma(uptime-kuma) | 2.21.1 |
| https://kubecost.github.io/cost-analyzer | kubecost(cost-analyzer) | 2.5.2-rc.2 |
| https://oauth2-proxy.github.io/manifests | oauth2proxy(oauth2-proxy) | 7.9.2 |

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
| argocd.server.containerPorts.http | int | `3000` |  |
| commonConfigMap | string | `"confixa-configmap"` |  |
| contour.enable | bool | `true` |  |
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
| kubecost.enable | bool | `true` |  |
| kubernetesdashboard.configMapRef | string | `"kubernetes-dashboard-settings"` |  |
| kubernetesdashboard.containerName | string | `"kubernetes-dashboard"` |  |
| kubernetesdashboard.enable | bool | `true` |  |
| kubernetesdashboard.kong.deployment.automountServiceAccountToken | bool | `true` |  |
| kubernetesdashboard.kong.deployment.name | string | `"admin-user"` |  |
| kubernetesdashboard.kong.env.ADMIN_LISTEN | string | `"off"` |  |
| kubernetesdashboard.kong.env.PORT_MAPS | string | `"80:8000, 443:8443"` |  |
| kubernetesdashboard.kong.env.PROXY_LISTEN | string | `"0.0.0.0:8000, [::]:8000, 0.0.0.0:8443 http2 ssl, [::]:8443 http2\nssl\n"` |  |
| kubernetesdashboard.kong.proxy.http.enabled | bool | `true` |  |
| kubernetesdashboard.kong.proxy.type | string | `"ClusterIP"` |  |
| kubernetesdashboard.metricsScraper.containerName | string | `"dashboard-metrics-scraper"` |  |
| kubernetesdashboard.metricsScraper.enable | bool | `true` |  |
| kubernetesdashboard.metricsScraper.name | string | `"dashboard-metrics-scraper"` |  |
| kubernetesdashboard.metricsScraper.service.port | int | `8000` |  |
| kubernetesdashboard.metricsScraper.service.targetPort | int | `8000` |  |
| kubernetesdashboard.name | string | `"kubernetes-dashboard"` |  |
| kubernetesdashboard.secret.certsSecretRef | string | `"kubernetes-dashboard-certs"` |  |
| kubernetesdashboard.secret.csrfSecretRef | string | `"kubernetes-dashboard-csrf"` |  |
| kubernetesdashboard.secret.tokenSecretRef | string | `"admin-user-token"` |  |
| kubernetesdashboard.service.port | int | `80` |  |
| kubernetesdashboard.service.targetPort | int | `9091` |  |
| kubernetesdashboard.serviceAccount.adminServiceAccountRef | string | `"admin-user"` |  |
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
| oauth2proxy.enable | bool | `true` |  |
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
| uptimekuma.enable | bool | `true` |  |
| uptimekuma.password | string | `"SystemHealth123!@#"` |  |
| uptimekuma.service.name | string | `"confixa-uptimekuma"` |  |
| uptimekuma.username | string | `"system-health"` |  |
| watcher.annotations.git | string | `"https://github.com/confixa/confixa-gitops.git"` |  |
| watcher.containerName | string | `"confixa-watcher"` |  |
| watcher.docker.dockerRef | string | `"docker-socket"` |  |
| watcher.docker.dockerType | string | `"Socket"` |  |
| watcher.docker.mountPath | string | `"/var/run/docker.sock"` |  |
| watcher.enable | bool | `true` |  |
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
| watcher.secret.variables.repoUrl | string | `"https://github.com/confixa/Confixa-FrontEnd.git"` |  |
| watcher.secret.variables.serviceAccountKeyPath | string | `"/tmp/service-account.json"` |  |
| watcher.serviceAccount.serviceAccountRef | string | `"confixa-configmap-watcher"` |  |
| watcher.serviceAccount.volumeRef | string | `"confixa-watcher-volume"` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.9.1](https://github.com/norwoodj/helm-docs/releases/v1.9.1)
