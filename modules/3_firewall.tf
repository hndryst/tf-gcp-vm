locals {
  fw = [
    {
      name = "allow-branch-1"
      tag  = "branch-1"
    },
    {
      name = "allow-branch-2"
      tag  = "branch-2"
    },
  ]
}


resource "google_compute_firewall" "allow-branch" {
  for_each = {
    for index, fw in local.fw :
    fw.name => fw
  }
  name    = each.value.name
  network = var.vpc
  project = var.host_project

  allow {
    protocol = "tcp"
  }
  source_tags = [each.value.tag]
  target_tags = [each.value.tag]
}

resource "google_compute_firewall" "allow-db-to-dwh" {
  name    = "allow-db-to-dwh"
  network = var.vpc
  project = var.host_project

  allow {
    protocol = "tcp"
  }
  source_tags = ["db"]
  target_tags = ["dwh"]
}

resource "google_compute_firewall" "allow-dwh-to-db" {
  name    = "allow-dwh-to-db"
  network = var.vpc
  project = var.host_project

  allow {
    protocol = "tcp"
  }
  source_tags = ["dwh"]
  target_tags = ["db"]
}
