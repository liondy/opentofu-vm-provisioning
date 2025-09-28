variable "project_id" {
  description = "The GCP project to deploy resources in."
  type        = string
  default     = "project"
}

variable "region" {
  description = "The GCP region for resources."
  type        = string
  default     = "asia-southeast2"
}

variable "zone" {
  description = "The GCP zone where the VM will reside."
  type        = string
  default     = "asia-southeast2-a"
}
