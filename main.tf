module "vpc_bobobox" {
  source     = "./vpc-bobobox"
  project_id = var.project_id
  region     = var.region
}

module "server_bobobox" {
  source               = "./server-bobobox"
  project_id           = var.project_id
  zone                 = var.zone
  network_self_link    = module.vpc_bobobox.network_self_link
  subnetwork_self_link = module.vpc_bobobox.subnetwork_self_link
  network_tag          = module.vpc_bobobox.network_tag
}

output "vm_public_ip" {
  description = "Public IP address of the bobobox web server instance."
  value       = module.server_bobobox.public_ip
}
