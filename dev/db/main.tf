module "db" {
  source      = "git::git@github.com:raehik/fuar-modules.git//db?ref=v0.0.1"
  module_root = "db.${var.env}.${var.root_fqdn}"

  instance_class = "db.t2.micro"
  db_password    = "${var.db_password}"
}
