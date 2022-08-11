provider "aws" {
    access_key = "XXXXXXXXXXXXXXXXXXXXX"
    secret_key = "XXXXXXXXXXXXXXXXXXXXX"
    region = "eu-central-1"
}

resource "aws_instance" "my_ubuntu" {
    ami = "ami-090f10efc254eaf55"
    instance_type = "t3.micro"
}

resource "aws_instance" "my_Amazon" {
    ami = "ami-03a71cec707bfc3d7"
    instance_type = "t3.micro"
}
