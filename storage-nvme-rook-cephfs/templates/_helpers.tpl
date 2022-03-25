{{/*
Expand the name of the chart.
*/}}
{{- define "storage-nvme-rook-cephfs.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "storage-nvme-rook-cephfs.fullname" -}}
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
{{- define "storage-nvme-rook-cephfs.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "storage-nvme-rook-cephfs.labels" -}}
helm.sh/chart: {{ include "storage-nvme-rook-cephfs.chart" . }}
{{ include "storage-nvme-rook-cephfs.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "storage-nvme-rook-cephfs.selectorLabels" -}}
app.kubernetes.io/name: {{ include "storage-nvme-rook-cephfs.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the operator service account to use
*/}}
{{- define "storage-nvme-rook-cephfs.operator.serviceAccountName" -}}
{{- $saname := default (include "storage-nvme-rook-cephfs.fullname" .) .Values.operator.serviceAccount.prefix }}
{{- printf "%s-operator" $saname }}
{{- end }}

{{/*
Create the name of the nfsserver service account to use
*/}}
{{- define "storage-nvme-rook-cephfs.nfsserver.serviceAccountName" -}}
{{- $saname := default (include "storage-nvme-rook-cephfs.fullname" .) .Values.nfsserver.serviceAccount.prefix }}
{{- printf "%s-nfsserver" $saname }}
{{- end }}