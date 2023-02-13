locals {
  app = [
    {
      ip_address = "192.168.0.1"
      name       = "branch-app-1"
      tag        = "branch-1"
    },
    {
      ip_address = "192.168.0.3"
      name       = "branch-app-2"
      tag        = "branch-2"
    },
  ]
  db = [
    {
      ip_address = "192.168.0.2"
      name       = "branch-db-1"
      tag        = "branch-1"
    },
    {
      ip_address = "192.168.0.4"
      name       = "branch-db-2"
      tag        = "branch-2"
    }
  ]
}

resource "google_compute_instance" "app" {
  for_each = {
    for index, vm in local.app :
    vm.name => vm
  }
  name         = each.value.name
  machine_type = "custom-2-8192"
  zone         = var.zone
  tags         = [each.value.tag, "app"]

  network_interface {
    network    = var.vpc
    subnetwork = var.subnet
    network_ip = each.value.ip_address
  }
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
      size  = 200
      type  = "pd-standard"
      labels = {
        type = "app"
      }
    }
  }
  service_account {
    email  = google_service_account.sa.email
    scopes = ["cloud-platform"]
  }
}

resource "google_compute_instance" "db" {
  for_each = {
    for index, vm in local.db :
    vm.name => vm
  }
  name         = each.value.name
  machine_type = "custom-2-8192"
  tags         = [each.value.tag, "db"]
  network_interface {
    network    = var.vpc
    subnetwork = var.subnet
    network_ip = each.value.ip_address
  }
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
      size  = 200
      type  = "pd-standard"
      labels = {
        type = "db"
      }
    }
  }
  service_account {
    email  = google_service_account.sa.email
    scopes = ["cloud-platform"]
  }
}

resource "google_compute_instance" "dwh" {
  name         = "dwh-1"
  machine_type = "custom-8-16384"
  tags         = ["dwh"]
  network_interface {
    network    = var.vpc
    subnetwork = var.subnet
    network_ip = "192.168.0.5"
  }
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
      size  = 500
      type  = "pd-standard"
      labels = {
        type = "db"
      }
    }
  }
  service_account {
    email  = google_service_account.sa.email
    scopes = ["cloud-platform"]
  }
}
