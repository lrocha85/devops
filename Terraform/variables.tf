# Variables file for more organization
variable "CONTAINER_PORT" {
    default = 80
}

variable "HOST_PORT" {
    default = 80
}

variable "IMAGEM_BACKEND" {
    default = "-----"
}

variable "IMAGEM_ONDEMAND" {
    default = "----"
}

variable "AWS_DEFAULT_REGION" {
    default = "us-east-1"
}

variable "ROLE" {
    default = "----"
}