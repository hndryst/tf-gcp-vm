Additional config needed:
1. terraform.tvars
project= "projectId"
host_project = "hostProjectId"
vpc = "vpcSelflink" -> gcloud compute networks describe vpcName --format="value(selfLink)"
subnet = "subnetSelflink" -> gcloud compute networks subnets describe subnetName --format="value(selfLink)" --region=subnetRegion

2. backend.hcl
bucket = "bucketname"
prefix = "dirname/state"

3. Init backend.tf
terraform init -backend-config=backend.hcl