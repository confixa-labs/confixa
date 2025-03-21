{{/* templates/_helpers.tpl */}}
{{/*
create readinessProbe for api gateway deployment
*/}}
{{- define "apiGateway.readinessProbe" -}}
failureThreshold: 3
initialDelaySeconds: 5
periodSeconds: 10
successThreshold: 1
tcpSocket:
  port: {{ .Values.apiGateway.ports.containerPort }}
timeoutSeconds: 1
{{- end }}

{{/*
create readinessProbe for argoCD API deployment
*/}}
{{- define "argoApi.readinessProbe" -}}
failureThreshold: 3
initialDelaySeconds: 5
periodSeconds: 10
successThreshold: 1
tcpSocket:
  port: {{ .Values.argoApi.ports.containerPort }}
timeoutSeconds: 1
{{- end }}


{{/*
create readinessProbe for LLM Backend deployment
*/}}
{{- define "llmBackend.readinessProbe" -}}
failureThreshold: 3
initialDelaySeconds: 5
periodSeconds: 10
successThreshold: 1
tcpSocket:
  port: {{ .Values.llmBackend.ports.containerPort }}
timeoutSeconds: 1
{{- end }}

{{/*
create readinessProbe for GitHub Actions API deployment
*/}}
{{- define "githubActionsApi.readinessProbe" -}}
failureThreshold: 3
initialDelaySeconds: 5
periodSeconds: 10
successThreshold: 1
tcpSocket:
  port: {{ .Values.githubActionsApi.ports.containerPort }}
timeoutSeconds: 1
{{- end }}

{{/*
create readinessProbe for GitHub API deployment
*/}}
{{- define "githubApi.readinessProbe" -}}
failureThreshold: 3
initialDelaySeconds: 5
periodSeconds: 10
successThreshold: 1
tcpSocket:
  port: {{ .Values.githubApi.ports.containerPort }}
timeoutSeconds: 1
{{- end }}

{{/*
create readinessProbe for GitHub API deployment
*/}}
{{- define "licenceApi.readinessProbe" -}}
failureThreshold: 3
initialDelaySeconds: 5
periodSeconds: 10
successThreshold: 1
tcpSocket:
  port: {{ .Values.licenceApi.ports.containerPort }}
timeoutSeconds: 1
{{- end }}

{{/*
create readinessProbe for O-Auth API deployment
*/}}
{{- define "oauthApp.readinessProbe" -}}
failureThreshold: 3
initialDelaySeconds: 5
periodSeconds: 10
successThreshold: 1
tcpSocket:
  port: {{ .Values.oauthApp.ports.containerPort }}
timeoutSeconds: 1
{{- end }}

{{/*
create readinessProbe for Support API deployment
*/}}
{{- define "supportApi.readinessProbe" -}}
failureThreshold: 3
initialDelaySeconds: 5
periodSeconds: 10
successThreshold: 1
tcpSocket:
  port: {{ .Values.supportApi.ports.containerPort }}
timeoutSeconds: 1
{{- end }}


{{/*
create readinessProbe for Uptime Kuma API deployment
*/}}
{{- define "uptimeKumaApi.readinessProbe" -}}
failureThreshold: 3
initialDelaySeconds: 5
periodSeconds: 10
successThreshold: 1
tcpSocket:
  port: {{ .Values.uptimeKumaApi.ports.containerPort }}
timeoutSeconds: 1
{{- end }}

{{/*
create readinessProbe for User Managment API deployment
*/}}
{{- define "userManagementApi.readinessProbe" -}}
failureThreshold: 3
initialDelaySeconds: 5
periodSeconds: 10
successThreshold: 1
tcpSocket:
  port: {{ .Values.userManagementApi.ports.containerPort }}
timeoutSeconds: 1
{{- end }}

{{/*
create readinessProbe for O-Auth 2 API deployment
*/}}
{{- define "oauthApi2.readinessProbe" -}}
failureThreshold: 3
initialDelaySeconds: 5
periodSeconds: 10
successThreshold: 1
tcpSocket:
  port: {{ .Values.oauthApi2.ports.containerPort }}
timeoutSeconds: 1
{{- end }}

{{/*
create readinessProbe for frontend deployment
*/}}
{{- define "frontend.readinessProbe" -}}
failureThreshold: 3
initialDelaySeconds: 5
periodSeconds: 10
successThreshold: 1
tcpSocket:
  port: {{ .Values.frontend.ports.containerPort }}
timeoutSeconds: 1
{{- end }}