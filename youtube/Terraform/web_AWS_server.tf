//provider "aws" {
//  region = "ru-central-1"
//}
resource "aws_eip" "my_static_ip" {
  instance = aws_instance.my_webserver.id
}
resource "aws_instance" "my_webserver" {
  ami = "ami-03a71cec707bfc3d7"
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.my_webserver-sec_group.id]

//  user_data = <<EOF
//#!/bin/bash
//yum -y update
//yum -y install httpd
//myip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
//echo "<h2>WebServer with IP: $myip</h2>Build by Terraform!" > /var/www/html/index.html
//sudo service httpd start
//chkconfig httpd on
//EOF

//  user_data = file("user_data.sh")

  user_data = templatefile("user_data.sh.tpl", {
    f_name = "MyName",
    l_name = "MyLastName",
    names = ["abcd","efg","adsaaaf"]
  })
  tags = {
    name = "My WebServer"
    Owner = "Me"
    Project = "Terraform Lesson 8"
  }
  lifecycle {
    // zero downtime
    create_before_destroy = true
    //не убивать сервер при выполнении terraform apply
    prevent_destroy = true
    //игнорировать изменения в разделах:
    ignore_changes = ["ami","user_data"]
  }
}

resource "aws_security_group" "my_webserver-sec_group" {
  name = "Web server security group"
  description = "My security group"

  dynamic "ingress" {
    for_each = ["80","443","8080"]
    content {
      from_port = ingress.value
      to_port = ingress.value
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["1.2.3.4/0"]
  }
/*  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
*/
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}