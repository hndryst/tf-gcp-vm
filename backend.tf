terraform {
  backend "gcs" {}
}

/*
terraform init -backend-config=backend.hcl
need backend.hcl file with the bucket name and prefix
bucket = "bucketname"
prefix = "dirname/state"
*/
