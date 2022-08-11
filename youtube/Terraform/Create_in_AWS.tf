provider "aws" {
    access_key = "XXXXXXXXXXXXXXXXXXXXX"
    secret_key = "XXXXXXXXXXXXXXXXXXXXX"
    region = "eu-central-1"
}

resource "aws_instance" "my_ubuntu" {
    count = 5
    ami = "ami-090f10efc254eaf55"
    instance_type = "t3.micro"
    tags = {
        name = "My Ubuntu Server"
        Owner = "Me"
        Project = "Terraform Lessons"
    }
}

resource "aws_instance" "my_Amazon" {
    ami = "ami-03a71cec707bfc3d7"
    instance_type = "t3.small"
    tags = {
        name = "My AWS Server"
        Owner = "Me"
        Project = "Terraform Lessons"
    }
}
