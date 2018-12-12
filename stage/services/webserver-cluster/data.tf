# all AZs specific to your AWS account
data "aws_availability_zones" "all" {}

# DB info (not sure if this is really good, have to hardcode something...)
data "terraform_remote_state" "db" {
  backend = "s3"

  config {
    region  = "${var.region}"
    bucket  = "${var.terraform_backend_s3_bucket}"
    key     = "stage/data-stores/mysql/terraform.tfstate"
    profile = "raehik@aws.raehik.net"
  }
}

# user data template
data "template_file" "user_data" {
  template = "${file("user-data.sh")}"

  vars {
    internal_http_port = "${var.internal_http_port}"
    db_address         = "${data.terraform_remote_state.db.address}"
    db_port            = "${data.terraform_remote_state.db.port}"
  }
}
