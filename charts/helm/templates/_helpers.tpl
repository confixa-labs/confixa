{{/* templates/_helpers.tpl */}}
{{/*
create readinessProbe for api gateway deployment
*/}}
{{- define "apiGateway.readinessProbe" -}}
failureThreshold: 3
initialDelaySeconds: 15
periodSeconds: 10
successThreshold: 1
tcpSocket:
  port: {{ .Values.apiGateway.ports.containerPort }}
timeoutSeconds: 5
{{- end }}

{{/*
create readinessProbe for frontend deployment
*/}}
{{- define "frontend.readinessProbe" -}}
failureThreshold: 3
initialDelaySeconds: 10
periodSeconds: 10
successThreshold: 1
tcpSocket:
  port: {{ .Values.frontend.ports.containerPort }}
timeoutSeconds: 3
{{- end }}

{{/*
create livenessProbe for api gateway deployment
*/}}
{{- define "apiGateway.livenessProbe" -}}
failureThreshold: 5
initialDelaySeconds: 30
periodSeconds: 15
successThreshold: 1
tcpSocket:
  port: {{ .Values.apiGateway.ports.containerPort }}
timeoutSeconds: 10
{{- end }}

{{/*
create livenessProbe for frontend deployment
*/}}
{{- define "frontend.livenessProbe" -}}
failureThreshold: 5
initialDelaySeconds: 30
periodSeconds: 15
successThreshold: 1
tcpSocket:
  port: {{ .Values.frontend.ports.containerPort }}
timeoutSeconds: 5
{{- end }}