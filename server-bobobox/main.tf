locals {
  instance_name      = "bobobox-web-server-1"
  machine_type       = "e2-medium"
  boot_image         = "projects/debian-cloud/global/images/family/debian-12"
  ansible_inventory  = templatefile("${path.module}/templates/inventory.ini", {})
  ansible_playbook   = templatefile("${path.module}/templates/site.yml", {})
  startup_script = templatefile(
    "${path.module}/templates/startup.sh.tftpl",
    {
      ansible_inventory = trimspace(local.ansible_inventory)
      ansible_playbook  = trimspace(local.ansible_playbook)
    }
  )
}

resource "google_compute_instance" "web_server" {
  name         = local.instance_name
  project      = var.project_id
  zone         = var.zone
  machine_type = local.machine_type
  tags         = [var.network_tag]

  boot_disk {
    initialize_params {
      image = local.boot_image
    }
  }

  network_interface {
    network    = var.network_self_link
    subnetwork = var.subnetwork_self_link

    access_config {}
  }

  metadata_startup_script = local.startup_script
}

output "public_ip" {
  description = "Public IP address of the bobobox web server."
  value       = google_compute_instance.web_server.network_interface[0].access_config[0].nat_ip
}
