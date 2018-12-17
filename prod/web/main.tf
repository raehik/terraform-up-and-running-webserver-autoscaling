module "web" {
  source      = "../../modules/web"
  module_root = "web.${var.env}.${var.root_fqdn}"

  instance_type             = "m4.large"
  http_autoscaling_min      = 2
  http_autoscaling_max      = 10
  http_port                 = 80
  db_terraform_state_region = "${var.region}"
  db_terraform_state_s3_bucket = "${var.terraform_backend_s3_bucket}"
  db_terraform_state_s3_key = "${var.env}/db/terraform.tfstate"
}
