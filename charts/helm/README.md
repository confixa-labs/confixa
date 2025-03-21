# Confixa

![Version: 0.8.3](https://img.shields.io/badge/Version-0.8.3-informational?style=flat-square) ![AppVersion: 0.8.3](https://img.shields.io/badge/AppVersion-0.8.3-informational?style=flat-square)

A Helm chart that deploys confixa-with-microservices-and-dependencies

**Homepage:** <https://confixa.com>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.bitnami.com/bitnami | argocd(argo-cd) | 7.0.20 |
| https://charts.bitnami.com/bitnami | contour(contour) | 19.4.0 |
| https://charts.bitnami.com/bitnami | mongodb(mongodb) | 16.0.3 |
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
| apiGateway.enable | bool | `true` |  |
| apiGateway.image.pullPolicy | string | `"Always"` |  |
| apiGateway.image.repository | string | `"asia-south1-docker.pkg.dev/confixa-rnd/confixa-docker-images/dev-confixa-api"` |  |
| apiGateway.image.tag | string | `"e87e971b97fd554a4da7f9fd3d8ed63960578189"` |  |
| apiGateway.name | string | `"confixa-api"` |  |
| apiGateway.ports.containerPort | int | `3000` |  |
| apiGateway.ports.protocol | string | `"TCP"` |  |
| apiGateway.replicas | int | `1` |  |
| apiGateway.resources.limits.cpu | string | `"500m"` |  |
| apiGateway.resources.limits.memory | string | `"512Mi"` |  |
| apiGateway.resources.requests.cpu | string | `"100m"` |  |
| apiGateway.resources.requests.memory | string | `"128Mi"` |  |
| apiGateway.service.port | int | `80` |  |
| apiGateway.service.protocol | string | `"TCP"` |  |
| apiGateway.service.targetPort | int | `3000` |  |
| apiGateway.service.type | string | `"ClusterIP"` |  |
| appName | string | `"confixa"` |  |
| argoApi.annotations.git | string | `"https://github.com/confixa/confixa-gitops.git"` |  |
| argoApi.configMapRef | string | `"argo-api"` |  |
| argoApi.containerName | string | `"argo-api"` |  |
| argoApi.enable | bool | `false` |  |
| argoApi.image.pullPolicy | string | `"Always"` |  |
| argoApi.image.repository | string | `"asia-south1-docker.pkg.dev/confixa-rnd/confixa-docker-images/dev-confixa-argo-api"` |  |
| argoApi.image.tag | string | `"8d02a6dd2020906ca8cfc79eb23e2e977a87ec6d"` |  |
| argoApi.name | string | `"argo-api"` |  |
| argoApi.ports.containerPort | int | `3000` |  |
| argoApi.ports.protocol | string | `"TCP"` |  |
| argoApi.replicas | int | `1` |  |
| argoApi.resources.limits.cpu | string | `"500m"` |  |
| argoApi.resources.limits.memory | string | `"512Mi"` |  |
| argoApi.resources.requests.cpu | string | `"100m"` |  |
| argoApi.resources.requests.memory | string | `"128Mi"` |  |
| argoApi.service.port | int | `80` |  |
| argoApi.service.protocol | string | `"TCP"` |  |
| argoApi.service.targetPort | int | `3000` |  |
| argoApi.service.type | string | `"ClusterIP"` |  |
| argocd.enable | bool | `false` |  |
| commonConfigMap | string | `"confixa-configmap"` |  |
| contour.enable | bool | `false` |  |
| frontend.annotations.git | string | `"https://github.com/confixa/confixa-gitops.git"` |  |
| frontend.configMapRef | string | `"confixa-frontend"` |  |
| frontend.containerName | string | `"confixa-frontend"` |  |
| frontend.enable | bool | `true` |  |
| frontend.image.pullPolicy | string | `"Always"` |  |
| frontend.image.repository | string | `"asia-south1-docker.pkg.dev/confixa-rnd/confixa-docker-images/dev-confixa-frontend"` |  |
| frontend.image.tag | string | `"25b75203f636631c1eba55fd5a14e94bc85f638c"` |  |
| frontend.name | string | `"confixa-frontend"` |  |
| frontend.ports.containerPort | int | `3001` |  |
| frontend.ports.protocol | string | `"TCP"` |  |
| frontend.replicas | int | `1` |  |
| frontend.resources.limits.cpu | string | `"500m"` |  |
| frontend.resources.limits.memory | string | `"512Mi"` |  |
| frontend.resources.requests.cpu | string | `"100m"` |  |
| frontend.resources.requests.memory | string | `"128Mi"` |  |
| frontend.service.port | int | `80` |  |
| frontend.service.protocol | string | `"TCP"` |  |
| frontend.service.targetPort | int | `3001` |  |
| frontend.service.type | string | `"ClusterIP"` |  |
| githubActionsApi.annotations.git | string | `"https://github.com/confixa/confixa-gitops.git"` |  |
| githubActionsApi.configMapRef | string | `"confixa-github-actions-api"` |  |
| githubActionsApi.containerName | string | `"confixa-github-actions-api"` |  |
| githubActionsApi.enable | bool | `false` |  |
| githubActionsApi.image.pullPolicy | string | `"Always"` |  |
| githubActionsApi.image.repository | string | `"asia-south1-docker.pkg.dev/confixa-rnd/confixa-docker-images/dev-confixa-github-actions-api"` |  |
| githubActionsApi.image.tag | string | `"6f0557c9680738af943ac1c86216f4d66402cf50"` |  |
| githubActionsApi.name | string | `"confixa-github-actions-api"` |  |
| githubActionsApi.ports.containerPort | int | `3000` |  |
| githubActionsApi.ports.protocol | string | `"TCP"` |  |
| githubActionsApi.replicas | int | `1` |  |
| githubActionsApi.resources.limits.cpu | string | `"500m"` |  |
| githubActionsApi.resources.limits.memory | string | `"512Mi"` |  |
| githubActionsApi.resources.requests.cpu | string | `"100m"` |  |
| githubActionsApi.resources.requests.memory | string | `"128Mi"` |  |
| githubActionsApi.service.port | int | `80` |  |
| githubActionsApi.service.protocol | string | `"TCP"` |  |
| githubActionsApi.service.targetPort | int | `3000` |  |
| githubActionsApi.service.type | string | `"ClusterIP"` |  |
| githubApi.annotations.git | string | `"https://github.com/confixa/confixa-gitops.git"` |  |
| githubApi.configMapRef | string | `"confixa-github-api"` |  |
| githubApi.containerName | string | `"confixa-github-api"` |  |
| githubApi.enable | bool | `false` |  |
| githubApi.image.pullPolicy | string | `"Always"` |  |
| githubApi.image.repository | string | `"asia-south1-docker.pkg.dev/confixa-rnd/confixa-docker-images/dev-confixa-github-api"` |  |
| githubApi.image.tag | string | `"26e9e7dbcb882aac197e129240e34ca69d275028"` |  |
| githubApi.name | string | `"confixa-github-api"` |  |
| githubApi.ports.containerPort | int | `3000` |  |
| githubApi.ports.protocol | string | `"TCP"` |  |
| githubApi.replicas | int | `1` |  |
| githubApi.resources.limits.cpu | string | `"500m"` |  |
| githubApi.resources.limits.memory | string | `"512Mi"` |  |
| githubApi.resources.requests.cpu | string | `"100m"` |  |
| githubApi.resources.requests.memory | string | `"128Mi"` |  |
| githubApi.service.port | int | `80` |  |
| githubApi.service.protocol | string | `"TCP"` |  |
| githubApi.service.targetPort | int | `3000` |  |
| githubApi.service.type | string | `"ClusterIP"` |  |
| kubecost.enable | bool | `false` |  |
| kubernetesdashboard.enabled | bool | `true` |  |
| kubernetesdashboard.kong.deployment.automountServiceAccountToken | bool | `true` |  |
| kubernetesdashboard.kong.deployment.name | string | `"admin-user"` |  |
| kubernetesdashboard.kong.env.ADMIN_LISTEN | string | `"off"` |  |
| kubernetesdashboard.kong.env.PORT_MAPS | string | `"80:8000, 443:8443"` |  |
| kubernetesdashboard.kong.env.PROXY_LISTEN | string | `"0.0.0.0:8000, [::]:8000, 0.0.0.0:8443 http2 ssl, [::]:8443 http2\nssl\n"` |  |
| kubernetesdashboard.kong.proxy.http.enabled | bool | `true` |  |
| kubernetesdashboard.kong.proxy.type | string | `"ClusterIP"` |  |
| kubernetesdashboard.metricsScraper.enabled | bool | `false` |  |
| licenceApi.annotations.git | string | `"https://github.com/confixa/confixa-gitops.git"` |  |
| licenceApi.configMapRef | string | `"confixa-licence-api"` |  |
| licenceApi.containerName | string | `"confixa-licence-api"` |  |
| licenceApi.enable | bool | `false` |  |
| licenceApi.image.pullPolicy | string | `"Always"` |  |
| licenceApi.image.repository | string | `"asia-south1-docker.pkg.dev/confixa-rnd/confixa-docker-images/dev-confixa-license-api"` |  |
| licenceApi.image.tag | string | `"26e9e7dbcb882aac197e129240e34ca69d275028"` |  |
| licenceApi.name | string | `"confixa-licence-api"` |  |
| licenceApi.ports.containerPort | int | `3008` |  |
| licenceApi.ports.protocol | string | `"TCP"` |  |
| licenceApi.replicas | int | `1` |  |
| licenceApi.resources.limits.cpu | string | `"500m"` |  |
| licenceApi.resources.limits.memory | string | `"512Mi"` |  |
| licenceApi.resources.requests.cpu | string | `"100m"` |  |
| licenceApi.resources.requests.memory | string | `"128Mi"` |  |
| licenceApi.service.port | int | `80` |  |
| licenceApi.service.protocol | string | `"TCP"` |  |
| licenceApi.service.targetPort | int | `3008` |  |
| licenceApi.service.type | string | `"ClusterIP"` |  |
| llmBackend.annotations.git | string | `"https://github.com/confixaconfixa-oauth-app/confixa-gitops.git"` |  |
| llmBackend.configMapRef | string | `"confixa-backend-llm"` |  |
| llmBackend.containerName | string | `"confixa-backend-llm"` |  |
| llmBackend.enable | bool | `false` |  |
| llmBackend.image.pullPolicy | string | `"Always"` |  |
| llmBackend.image.repository | string | `"asia-south1-docker.pkg.dev/confixa-rnd/confixa-docker-images/dev-confixa-backend-llm"` |  |
| llmBackend.image.tag | string | `"55eecec4a4ac4fb943d8d7be418b454b1989f920"` |  |
| llmBackend.name | string | `"confixa-backend-llm"` |  |
| llmBackend.ports.containerPort | int | `5011` |  |
| llmBackend.ports.protocol | string | `"TCP"` |  |
| llmBackend.replicas | int | `1` |  |
| llmBackend.resources.limits.cpu | string | `"500m"` |  |
| llmBackend.resources.limits.memory | string | `"512Mi"` |  |
| llmBackend.resources.requests.cpu | string | `"100m"` |  |
| llmBackend.resources.requests.memory | string | `"128Mi"` |  |
| llmBackend.service.port | int | `80` |  |
| llmBackend.service.protocol | string | `"TCP"` |  |
| llmBackend.service.targetPort | int | `5011` |  |
| llmBackend.service.type | string | `"ClusterIP"` |  |
| mongodb.auth.databases[0] | string | `"confixa"` |  |
| mongodb.auth.passwords[0] | string | `"{{ randAlphaNum 16 | b64enc }}"` |  |
| mongodb.auth.rootPassword | string | `"{{ randAlphaNum 16 | b64enc }}"` |  |
| mongodb.auth.rootUser | string | `"root"` |  |
| mongodb.auth.usernames[0] | string | `"confixaadmin"` |  |
| mongodb.enable | bool | `true` |  |
| oauth2proxy.enable | bool | `true` |  |
| oauthApi2.annotations.git | string | `"https://github.com/confixa/confixa-gitops.git"` |  |
| oauthApi2.configMapRef | string | `"confixa-oauth-app"` |  |
| oauthApi2.containerName | string | `"confixa-oauth-app"` |  |
| oauthApi2.enable | bool | `false` |  |
| oauthApi2.image.pullPolicy | string | `"Always"` |  |
| oauthApi2.image.repository | string | `"asia-south1-docker.pkg.dev/confixa-rnd/confixa-docker-images/confixa-oauth-app"` |  |
| oauthApi2.image.tag | string | `"1199e5eba9e5b2210089a379386a42d29a85857d"` |  |
| oauthApi2.name | string | `"confixa-oauth-app"` |  |
| oauthApi2.ports.containerPort | int | `3019` |  |
| oauthApi2.ports.protocol | string | `"TCP"` |  |
| oauthApi2.replicas | int | `1` |  |
| oauthApi2.resources.limits.cpu | string | `"500m"` |  |
| oauthApi2.resources.limits.memory | string | `"512Mi"` |  |
| oauthApi2.resources.requests.cpu | string | `"100m"` |  |
| oauthApi2.resources.requests.memory | string | `"128Mi"` |  |
| oauthApi2.service.port | int | `80` |  |
| oauthApi2.service.protocol | string | `"TCP"` |  |
| oauthApi2.service.targetPort | int | `3019` |  |
| oauthApi2.service.type | string | `"ClusterIP"` |  |
| oauthApp.annotations.git | string | `"https://github.com/confixa/confixa-gitops.git"` |  |
| oauthApp.configMapRef | string | `"confixa-oauth-app"` |  |
| oauthApp.containerName | string | `"confixa-oauth-app"` |  |
| oauthApp.enable | bool | `false` |  |
| oauthApp.image.pullPolicy | string | `"Always"` |  |
| oauthApp.image.repository | string | `"asia-south1-docker.pkg.dev/confixa-rnd/confixa-docker-images/confixa-oauth-app"` |  |
| oauthApp.image.tag | string | `"1199e5eba9e5b2210089a379386a42d29a85857d"` |  |
| oauthApp.name | string | `"confixa-oauth-app"` |  |
| oauthApp.ports.containerPort | int | `3018` |  |
| oauthApp.ports.protocol | string | `"TCP"` |  |
| oauthApp.replicas | int | `1` |  |
| oauthApp.resources.limits.cpu | string | `"500m"` |  |
| oauthApp.resources.limits.memory | string | `"512Mi"` |  |
| oauthApp.resources.requests.cpu | string | `"100m"` |  |
| oauthApp.resources.requests.memory | string | `"128Mi"` |  |
| oauthApp.service.port | int | `80` |  |
| oauthApp.service.protocol | string | `"TCP"` |  |
| oauthApp.service.targetPort | int | `3018` |  |
| oauthApp.service.type | string | `"ClusterIP"` |  |
| passwordSecretsManagerName | string | `"confixa-passwords-secret"` |  |
| rabbitmq.auth.username | string | `"admin"` |  |
| rabbitmq.enable | bool | `true` |  |
| redis.auth.enabled | bool | `true` |  |
| redis.auth.password | string | `"{{ randAlphaNum 16 | b64enc }}"` |  |
| redis.enabled | bool | `true` |  |
| redis.master.nodeSelector | object | `{}` |  |
| redis.replica.nodeSelector | object | `{}` |  |
| redis.replica.replicaCount | int | `1` |  |
| supportApi.annotations.git | string | `"https://github.com/confixa/confixa-gitops.git"` |  |
| supportApi.configMapRef | string | `"confixa-support-api"` |  |
| supportApi.containerName | string | `"confixa-support-api"` |  |
| supportApi.enable | bool | `false` |  |
| supportApi.image.pullPolicy | string | `"Always"` |  |
| supportApi.image.repository | string | `"asia-south1-docker.pkg.dev/confixa-rnd/confixa-docker-images/confixa-support-api"` |  |
| supportApi.image.tag | string | `"64857c1406e2c2510fbad993c7641163ba2f7b61"` |  |
| supportApi.name | string | `"confixa-support-api"` |  |
| supportApi.ports.containerPort | int | `3000` |  |
| supportApi.ports.protocol | string | `"TCP"` |  |
| supportApi.replicas | int | `1` |  |
| supportApi.resources.limits.cpu | string | `"500m"` |  |
| supportApi.resources.limits.memory | string | `"512Mi"` |  |
| supportApi.resources.requests.cpu | string | `"100m"` |  |
| supportApi.resources.requests.memory | string | `"128Mi"` |  |
| supportApi.service.port | int | `80` |  |
| supportApi.service.protocol | string | `"TCP"` |  |
| supportApi.service.targetPort | int | `3000` |  |
| supportApi.service.type | string | `"ClusterIP"` |  |
| uptimeKumaApi.annotations.git | string | `"https://github.com/confixa/confixa-gitops.git"` |  |
| uptimeKumaApi.configMapRef | string | `"confixa-uptime-kuma"` |  |
| uptimeKumaApi.containerName | string | `"confixa-uptime-kuma"` |  |
| uptimeKumaApi.enable | bool | `false` |  |
| uptimeKumaApi.image.pullPolicy | string | `"Always"` |  |
| uptimeKumaApi.image.repository | string | `"asia-south1-docker.pkg.dev/confixa-rnd/confixa-docker-images/confixa-uptime-kuma"` |  |
| uptimeKumaApi.image.tag | string | `"a6dd5fccdc6cf256def93893814e75ceef490e10"` |  |
| uptimeKumaApi.name | string | `"confixa-uptime-kuma"` |  |
| uptimeKumaApi.ports.containerPort | int | `5050` |  |
| uptimeKumaApi.ports.protocol | string | `"TCP"` |  |
| uptimeKumaApi.replicas | int | `1` |  |
| uptimeKumaApi.resources.limits.cpu | string | `"500m"` |  |
| uptimeKumaApi.resources.limits.memory | string | `"512Mi"` |  |
| uptimeKumaApi.resources.requests.cpu | string | `"100m"` |  |
| uptimeKumaApi.resources.requests.memory | string | `"128Mi"` |  |
| uptimeKumaApi.service.port | int | `80` |  |
| uptimeKumaApi.service.protocol | string | `"TCP"` |  |
| uptimeKumaApi.service.targetPort | int | `5050` |  |
| uptimeKumaApi.service.type | string | `"ClusterIP"` |  |
| uptimekuma.enable | bool | `false` |  |
| userManagementApi.annotations.git | string | `"https://github.com/confixa/confixa-gitops.git"` |  |
| userManagementApi.configMapRef | string | `"confixa-user-management"` |  |
| userManagementApi.containerName | string | `"confixa-user-management"` |  |
| userManagementApi.enable | bool | `false` |  |
| userManagementApi.image.pullPolicy | string | `"Always"` |  |
| userManagementApi.image.repository | string | `"asia-south1-docker.pkg.dev/confixa-rnd/confixa-docker-images/dev-confixa-user-management"` |  |
| userManagementApi.image.tag | string | `"ca87d34cfb467b9fd14ace984b83a9482116aab8"` |  |
| userManagementApi.name | string | `"confixa-user-management"` |  |
| userManagementApi.ports.containerPort | int | `3000` |  |
| userManagementApi.ports.protocol | string | `"TCP"` |  |
| userManagementApi.replicas | int | `1` |  |
| userManagementApi.resources.limits.cpu | string | `"500m"` |  |
| userManagementApi.resources.limits.memory | string | `"512Mi"` |  |
| userManagementApi.resources.requests.cpu | string | `"100m"` |  |
| userManagementApi.resources.requests.memory | string | `"128Mi"` |  |
| userManagementApi.service.port | int | `80` |  |
| userManagementApi.service.protocol | string | `"TCP"` |  |
| userManagementApi.service.targetPort | int | `3000` |  |
| userManagementApi.service.type | string | `"ClusterIP"` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.9.1](https://github.com/norwoodj/helm-docs/releases/v1.9.1)
