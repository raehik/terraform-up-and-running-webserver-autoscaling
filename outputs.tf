output "http_public_ipv4" {
  value = "${aws_instance.example.public_ip}"
}
