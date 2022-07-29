{{/*
Expand the name of the chart.
*/}}
{{- define "business-app.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "business-app.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}


{{/*
Create a default fully qualified Kubernetes Service Name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a Kubernetes Service Name.
*/}}
{{- define "business-app.serviceName" -}}
{{- if .Values.fullnameOverride }}
    {{- printf "%s-%s" .Values.fullnameOverride "service" | trunc 63 | trimSuffix "-" }}
{{- else if .Values.service.name }}
        {{- printf "%s-%s" .Values.service.name "service" | trunc 63 | trimSuffix "-" }}
    {{- else }}
    {{- $name := default .Chart.Name .Values.nameOverride }}
        {{- if contains $name .Release.Name }}
            {{- printf "%s-%s" .Release.Name "service" | trunc 63 | trimSuffix "-" }}
        {{- else }}
            {{- printf "%s-%s-%s" .Release.Name $name "service" | trunc 63 | trimSuffix "-" }}
        {{- end }}
    {{- end }}
{{- end }}



{{/*
Create a default fully qualified Kubernetes Ingress Name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a Kubernetes Ingress Name.
*/}}
{{- define "business-app.ingressName" -}}
{{- if .Values.fullnameOverride }}
    {{- printf "%s-%s" .Values.fullnameOverride "ingress"  | trunc 63 | trimSuffix "-" }}
{{- else if .Values.ingress.name }}
        {{- printf "%s-%s" .Values.ingress.name "ingress" | trunc 63 | trimSuffix "-" }}
    {{- else }}
    {{- $name := default .Chart.Name .Values.nameOverride }}
        {{- if contains $name .Release.Name }}
            {{- printf "%s-%s" .Release.Name "ingress" | trunc 63 | trimSuffix "-" }}
        {{- else }}
            {{- printf "%s-%s-%s" .Release.Name $name "ingress" | trunc 63 | trimSuffix "-" }}
        {{- end }}
    {{- end }}
{{- end }}




{{/*
Create a default fully qualified Kubernetes Deployment Name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a Kubernetes Deployment Name.
*/}}
{{- define "business-app.deploymentName" -}}
{{- if .Values.fullnameOverride }}
    {{- printf "%s-%s" .Values.fullnameOverride "deployment" | trunc 63 | trimSuffix "-" }}
{{- else if .Values.deployment.name }}
        {{- printf "%s-%s" .Values.deployment.name "deployment" | trunc 63 | trimSuffix "-" }}
    {{- else }}
    {{- $name := default .Chart.Name .Values.nameOverride }}
        {{- if contains $name .Release.Name }}
            {{- printf "%s-%s" .Release.Name "deployment" | trunc 63 | trimSuffix "-" }}
        {{- else }}
            {{- printf "%s-%s-%s" .Release.Name $name "deployment" | trunc 63 | trimSuffix "-" }}
        {{- end }}
    {{- end }}
{{- end }}





{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "business-app.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "business-app.labels" -}}
helm.sh/chart: {{ include "business-app.chart" . }}
{{ include "business-app.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "business-app.selectorLabels" -}}
app.kubernetes.io/instance: {{ .Values.environment.releaseName }}
app.kubernetes.io/name: {{ include "business-app.name" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}



{{/*
Create the name of the service account to use
*/}}
{{- define "business-app.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "business-app.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}


{{/*
Common Annotations
*/}}
{{- define "business-app.CommonAnnotations" -}}
{{- end }}


 

{{/*
  Ingress Annotations for LB and Health Checks
*/}}
{{- define "business-app.defaultIngressAnnotations" -}}
kubernetes.io/ingress.class: {{ .Values.ingress.defaultAnnotations.ingressType.ingressClass }}
{{ .Values.ingress.defaultAnnotations.ingressType.ingressClass }}.ingress.kubernetes.io/scheme: {{ .Values.ingress.defaultAnnotations.ingressType.ingressScheme }}
{{ .Values.ingress.defaultAnnotations.ingressType.ingressClass }}.ingress.kubernetes.io/target-type: {{ .Values.ingress.defaultAnnotations.ingressType.ingressTargetType }}
{{ .Values.ingress.defaultAnnotations.ingressType.ingressClass }}.ingress.kubernetes.io/healthcheck-protocol: {{ .Values.ingress.defaultAnnotations.healthCheck.healthCheckProtocol }}
{{ .Values.ingress.defaultAnnotations.ingressType.ingressClass }}.ingress.kubernetes.io/healthcheck-path: {{ .Values.ingress.defaultAnnotations.healthCheck.healthCheckPath }}
{{ .Values.ingress.defaultAnnotations.ingressType.ingressClass }}.ingress.kubernetes.io/healthcheck-interval-seconds: {{ .Values.ingress.defaultAnnotations.healthCheck.healthCheckIntervalSeconds }}
{{ .Values.ingress.defaultAnnotations.ingressType.ingressClass }}.ingress.kubernetes.io/healthcheck-timeout-seconds: {{ .Values.ingress.defaultAnnotations.healthCheck.healthCheckTimeoutSeconds }}
{{ .Values.ingress.defaultAnnotations.ingressType.ingressClass }}.ingress.kubernetes.io/success-codes: {{ .Values.ingress.defaultAnnotations.healthCheck.heathCheckSuccessCodes }}
{{ .Values.ingress.defaultAnnotations.ingressType.ingressClass }}.ingress.kubernetes.io/healthy-threshold-count: {{ .Values.ingress.defaultAnnotations.healthCheck.healthyThresholdCount }}
{{ .Values.ingress.defaultAnnotations.ingressType.ingressClass }}.ingress.kubernetes.io/unhealthy-threshold-count: {{ .Values.ingress.defaultAnnotations.healthCheck.unhealthyThresholdCount }}
{{- end }}
