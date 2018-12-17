module "terraform_backend" {
  source = "../../modules/terraform-backend-s3"
  module_root = "${var.root_fqdn}"

  terraform_backend_s3_bucket = "${var.terraform_backend_s3_bucket}"
  terraform_backend_s3_dynamodb_table = "${var.terraform_backend_s3_dynamodb_table}"
}
