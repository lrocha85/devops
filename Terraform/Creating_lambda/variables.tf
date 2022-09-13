variable "LAMBDA_NAME" {
    default = "name"
    type = string
}

variable "ROLE" {
    default = "name"
    type = string
}

variable "REPOSITORY" {
    default = "https://REPO.git"
}

variable "BRANCH" {
    default = "master"
}

variable "FILENAME" {
    default = "deployment-package.zip"
}

variable "FOLDER_NAME" {
    default = "folder_name"
}