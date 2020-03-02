resource "aws_elb" "heavy" {
  name                      = "tf-${var.service_instance_name}-elb"
  subnets                   = var.subnets
  security_groups           = ["${aws_security_group.lb_sg.id}"]
  cross_zone_load_balancing = true
  idle_timeout              = 60

  listener {
    instance_port     = 80
    instance_protocol = "HTTP"
    lb_port           = 80
    lb_protocol       = "HTTP"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    interval            = 7
    timeout             = 5
    target              = "${var.app_protocol}:${var.app_port}${var.app_health_check_uri}"
  }

  lifecycle {
    create_before_destroy = false
  }
}
