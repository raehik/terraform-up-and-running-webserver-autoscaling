provider "aws" {
  region  = "${var.region}"
  profile = "raehik@aws.raehik.net"
}

resource "aws_db_instance" "web" {
  engine            = "mysql"
  allocated_storage = 10
  instance_class    = "db.t2.micro"
  name              = "example_database"
  username          = "${var.db_username}"
  password          = "${var.db_password}"
}
