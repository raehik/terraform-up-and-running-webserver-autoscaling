resource "aws_launch_configuration" "http_autoscaling" {
  image_id        = "ami-0bdf93799014acdc4"
  instance_type   = "${var.instance_type}"
  security_groups = ["${aws_security_group.internal_http_only.id}"]
  user_data       = "${data.template_file.user_data.rendered}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "http_autoscaling" {
  launch_configuration = "${aws_launch_configuration.http_autoscaling.id}"
  availability_zones   = ["${data.aws_availability_zones.all.names}"]

  load_balancers    = ["${aws_elb.http_autoscaling.id}"]
  health_check_type = "ELB"

  min_size = "${var.http_autoscaling_min}"
  max_size = "${var.http_autoscaling_max}"

  tag {
    key                 = "Name"
    value               = "${var.module_root}"
    propagate_at_launch = true
  }
}

resource "aws_elb" "http_autoscaling" {
  name               = "${replace(var.module_root, "/\\./", "-")}"
  availability_zones = ["${data.aws_availability_zones.all.names}"]
  security_groups    = ["${aws_security_group.elb.id}"]

  listener {
    lb_port           = "${var.http_port}"
    lb_protocol       = "http"
    instance_port     = "${var.internal_http_port}"
    instance_protocol = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
    target              = "HTTP:${var.internal_http_port}/"
  }
}

resource "aws_security_group" "elb" {
  name = "${var.module_root}-http-only"

  ingress {
    from_port   = "${var.http_port}"
    to_port     = "${var.http_port}"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "internal_http_only" {
  name = "${var.module_root}-internal-http-only"

  ingress {
    from_port   = "${var.internal_http_port}"
    to_port     = "${var.internal_http_port}"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}
