variable "region" {
  description = "AWS region"
}

variable "http_port" {
  description = "port to handle HTTP requests"
}

variable "http_autoscaling_min" {
  description = "minimum instances for the HTTP server autoscaling group"
}

variable "http_autoscaling_max" {
  description = "maximum instances for the HTTP server autoscaling group"
}
