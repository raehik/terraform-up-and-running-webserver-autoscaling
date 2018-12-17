module "db" {
  source      = "../../modules/db"
  module_root = "db.${var.env}.${var.root_fqdn}"

  instance_class = "db.t2.medium"
  db_password    = "${var.db_password}"
}
