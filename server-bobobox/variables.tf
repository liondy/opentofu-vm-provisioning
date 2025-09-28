variable "project_id" {
  description = "Project id for compute resources."
  type        = string
}

variable "zone" {
  description = "Zone where the instance will be provisioned."
  type        = string
}

variable "network_self_link" {
  description = "Self link of the VPC network to attach the instance to."
  type        = string
}

variable "subnetwork_self_link" {
  description = "Self link of the subnetwork for the instance."
  type        = string
}

variable "network_tag" {
  description = "Network tag to associate with the instance for firewall rules."
  type        = string
}
