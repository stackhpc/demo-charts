{{/*
Expand the name of the chart.
*/}}
{{- define "storage-nvme-rook-nfs.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "storage-nvme-rook-nfs.fullname" -}}
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
{{- define "storage-nvme-rook-nfs.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "storage-nvme-rook-nfs.labels" -}}
helm.sh/chart: {{ include "storage-nvme-rook-nfs.chart" . }}
{{ include "storage-nvme-rook-nfs.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "storage-nvme-rook-nfs.selectorLabels" -}}
app.kubernetes.io/name: {{ include "storage-nvme-rook-nfs.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the operator service account to use
*/}}
{{- define "storage-nvme-rook-nfs.operator.serviceAccountName" -}}
{{- $saname := default (include "storage-nvme-rook-nfs.fullname" .) .Values.operator.serviceAccount.prefix }}
{{- printf "%s-operator" $saname }}
{{- end }}

{{/*
Create the name of the nfsserver service account to use
*/}}
{{- define "storage-nvme-rook-nfs.nfsserver.serviceAccountName" -}}
{{- $saname := default (include "storage-nvme-rook-nfs.fullname" .) .Values.nfsserver.serviceAccount.prefix }}
{{- printf "%s-operator" $saname }}
{{- end }}