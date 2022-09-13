# Saving the terraform status on S3
terraform {
  backend "s3" {
    bucket = "name"
    key    = "name_folder/terraform.tfstate"
    region = "us-east-1"
  }
}