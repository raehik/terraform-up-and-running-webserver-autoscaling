module "web" {
  source      = "../../modules/web"
  module_root = "web.${var.env}.${var.root_fqdn}"

  instance_type                = "m4.large"
  http_autoscaling_min         = 2
  http_autoscaling_max         = 10
  http_port                    = 80
  db_terraform_state_region    = "${var.region}"
  db_terraform_state_s3_bucket = "${var.terraform_backend_s3_bucket}"
  db_terraform_state_s3_key    = "${var.env}/db/terraform.tfstate"
}

resource "aws_autoscaling_schedule" "scale_out_during_business_hours" {
  autoscaling_group_name = "${module.web.asg_name}"
  scheduled_action_name  = "scale-out-during-business-hours"
  min_size               = 2
  max_size               = 10
  desired_capacity       = 10
  recurrence             = "0 9 * * *"
}

resource "aws_autoscaling_schedule" "scale_in_at_night" {
  autoscaling_group_name = "${module.web.asg_name}"
  scheduled_action_name  = "scale-in-at-night"
  min_size               = 2
  max_size               = 10
  desired_capacity       = 2
  recurrence             = "0 17 * * *"
}
