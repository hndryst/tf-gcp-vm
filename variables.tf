variable "project" {
  type    = string
  default = ""
}
variable "region" {
  type    = string
  default = "asia-southeast2"
}
variable "zone" {
  type    = string
  default = "asia-southeast2-a"
}
variable "compute_sa" {
  type    = string
  default = "compute-sa"
}
variable "vpc" {
  type    = string
  default = ""
}
variable "subnet" {
  type    = string
  default = ""
}
variable "host_project" {
  type    = string
  default = ""
}
/*
need terraform.tvars file for additional config
project= "projectId"
host_project = "hostProjectId"
vpc = vpc selflink -> gcloud compute networks describe vpcName --format="value(selfLink)"
subnet = subnet selflink -> gcloud compute networks subnets describe subnetName --format="value(selfLink)" --region=subnetRegion
*/
