provider "aws" {
  region  = "eu-central-1"
  profile = "raehik@aws.raehik.net"
}

resource "aws_instance" "example" {
  ami                    = "ami-0bdf93799014acdc4"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.instance.id}"]

  tags {
    Name = "terraform-example"
  }

  user_data = <<-EOF
    #!/bin/bash
    echo "Hello, world!" > index.html
    nohup busybox httpd -f -p ${var.http_port} &
    EOF
}

resource "aws_security_group" "instance" {
  name = "terraform-example-instance"

  ingress {
    from_port   = "${var.http_port}"
    to_port     = "${var.http_port}"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
