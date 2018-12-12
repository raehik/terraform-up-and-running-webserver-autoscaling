module "mysql" {
  source      = "../../../modules/data-stores/mysql"
  module_root = "db.${var.env}.${var.root_fqdn}"

  instance_class = "db.t2.medium"
  db_password    = "${var.db_password}"
}