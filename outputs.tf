output "http_public_fqdn" {
  value = "${aws_elb.http_autoscaling.dns_name}"
}
