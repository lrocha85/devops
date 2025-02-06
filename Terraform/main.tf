# Set the region
provider "aws" {
  region = "us-east-1"
}

#Here i'm creating a remote states for terraform, this is very important when you work with a team
terraform {
  backend "s3" {
    bucket = "----"
    key    = "----"
    region = "us-east-1"
  }
}