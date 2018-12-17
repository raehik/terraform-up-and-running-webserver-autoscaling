module "web" {
  source      = "../../modules/web"
  module_root = "web.${var.env}.${var.root_fqdn}"

  instance_type                = "t2.micro"
  http_autoscaling_min         = 2
  http_autoscaling_max         = 2
  http_port                    = 80
  db_terraform_state_region    = "${var.region}"
  db_terraform_state_s3_bucket = "${var.terraform_backend_s3_bucket}"
  db_terraform_state_s3_key    = "${var.env}/db/terraform.tfstate"
}

resource "aws_security_group_rule" "allow_testing_inbound" {
  type              = "ingress"
  security_group_id = "${module.web.elb_security_group_id}"
  from_port         = "${var.elb_test_port}"
  to_port           = "${var.elb_test_port}"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}
