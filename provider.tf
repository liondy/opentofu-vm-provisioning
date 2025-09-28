terraform {
  required_version = ">= 1.6.0"

  backend "gcs" {
    bucket = "box-terraform-state"
    prefix = "opentofu-web-server"
  }

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}
