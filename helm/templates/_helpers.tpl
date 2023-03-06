{{/*
Expand the name of the chart.
*/}}
{{- define "vault-oss-backup.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "vault-oss-backup.fullname" -}}
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
Create chart name and version as used by the chart label.
*/}}
{{- define "vault-oss-backup.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create backup schedule labels.
*/}}
{{- define "vault-oss-backup.schedule" -}}
{{- .Values.backupConfigs.schedule | trimPrefix "@" | replace " " "-" | trunc 63 | trimSuffix "-"  }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "vault-oss-backup.labels" -}}
helm.sh/chart: {{ include "vault-oss-backup.chart" . }}
{{ include "vault-oss-backup.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/backup-schedule: {{ include "vault-oss-backup.schedule" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "vault-oss-backup.selectorLabels" -}}
app.kubernetes.io/name: {{ include "vault-oss-backup.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "vault-oss-backup.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "vault-oss-backup.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
