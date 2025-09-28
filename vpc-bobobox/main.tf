locals {
  network_name   = "vpc-bobobox"
  subnetwork_name = "subnet-bobobox"
  firewall_name  = "allow-http-ssh-bobobox"
  network_tag    = "bobobox-web"
}

resource "google_compute_network" "vpc" {
  name                            = local.network_name
  project                         = var.project_id
  auto_create_subnetworks         = false
  delete_default_routes_on_create = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = local.subnetwork_name
  project       = var.project_id
  region        = var.region
  network       = google_compute_network.vpc.id
  ip_cidr_range = "10.10.0.0/24"
}

resource "google_compute_firewall" "allow_http_ssh" {
  name    = local.firewall_name
  project = var.project_id
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22", "80"]
  }

  direction     = "INGRESS"
  source_ranges = ["0.0.0.0/0"]
  target_tags   = [local.network_tag]
}

output "network_self_link" {
  description = "Self link of the bobobox VPC."
  value       = google_compute_network.vpc.self_link
}

output "subnetwork_self_link" {
  description = "Self link of the subnetwork for server instances."
  value       = google_compute_subnetwork.subnet.self_link
}

output "subnetwork_name" {
  description = "Name of the subnetwork for reference."
  value       = google_compute_subnetwork.subnet.name
}

output "network_tag" {
  description = "Network tag applied for firewall rules."
  value       = local.network_tag
}
