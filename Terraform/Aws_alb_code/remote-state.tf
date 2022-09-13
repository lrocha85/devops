# Here i'm creating a remote states for terraform, this is very important when you work with a team
terraform {
  backend "s3" {
    bucket = "bucket-name"
    key    = "folder-name/terraform.tfstate"
    region = "us-east-1"
  }
}