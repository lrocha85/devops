provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "teste" {
    ami = "ami-6edd3078"
    instance_type = "t2.micro"
}
