variable "name" {
  description = "Name of helm release"
  type        = string
  default     = "metrics-server"
}

variable "repository" {
  description = "Url of repository"
  type        = string
  default     = "https://kubernetes-sigs.github.io/metrics-server/"
}

variable "chart" {
  description = "Chart of helm release"
  type        = string
  default     = "metrics-server"
}

variable "namespace" {
  description = "namespace of helm release"
  type        = string
  default     = "kube-system"
}

variable "create_namespace" {
  description = "Create namespace ?"
  type        = bool
  default     = false
}

variable "release_version" {
  description = "version of helm release"
  type        = string
  default     = null
}

variable "images" {
  description = "Map of images"
  type        = map(string)
  default     = {}
}

variable "values" {
  description = "Values"
  type        = list(any)
  default     = []
}
