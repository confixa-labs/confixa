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