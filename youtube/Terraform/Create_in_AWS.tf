provider "aws" {
    access_key = "XXXXXXXXXXXXXXXXXXXXX"
    secret_key = "XXXXXXXXXXXXXXXXXXXXX"
    region = "eu-central-1"
}

resource "aws_instance" "my_ubuntu" {
    ami = "ami-090f10efc254eaf55"
    instance.type = "t3.micro"
}
