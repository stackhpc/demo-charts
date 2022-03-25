{{/*
Expand the name of the chart.
*/}}
{{- define "kubeflow-installer.name" -}}
{{- .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "kubeflow-installer.fullname" -}}
{{- if contains .Chart.Name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "kubeflow-installer.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Selector labels for a chart-level resource.
*/}}
{{- define "kubeflow-installer.selectorLabels" -}}
app.kubernetes.io/name: {{ include "kubeflow-installer.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Labels for a chart-level resource.
*/}}
{{- define "kubeflow-installer.labels" -}}
helm.sh/chart: {{ include "kubeflow-installer.chart" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
{{ include "kubeflow-installer.selectorLabels" . }}
{{- end }}

{{/*
Renders the default job configuration.
*/}}
{{- define "kubeflow-installer.job.defaults" -}}
{{- $ctx := index . 0 }}
{{- $name := index . 1 }}
{{- with $ctx.Values.jobDefaults }}
{{- toYaml . }}
{{- end }}
{{- if $ctx.Values.kubeconfigSecret.name }}
kubeconfigSecret:
  name: {{ tpl $ctx.Values.kubeconfigSecret.name $ctx }}
  {{- with $ctx.Values.kubeconfigSecret.key }}
  key: {{ . }}
  {{- end }}
{{- end }}
serviceAccountName: {{ tpl $ctx.Values.serviceAccount.name $ctx }}
{{- end }}


