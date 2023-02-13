terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.41.0"
    }

  }
}

provider "google" {
  project = var.project
  region  = var.region
  zone    = var.zone
}

module "gcp" {
  source       = "./modules"
  project      = var.project
  compute_sa   = var.compute_sa
  host_project = var.host_project
  vpc          = var.vpc
  subnet       = var.subnet
}
