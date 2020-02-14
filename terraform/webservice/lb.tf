resource "aws_lb" "front_end" {
  name = "tf-${var.service_name}-lb"
  load_balancer_type = "application"
  subnets = var.subnets
  security_groups = [ "${aws_security_group.lb_sg.id}" ]

  internal = false
  enable_cross_zone_load_balancing = true
  idle_timeout = 60

  tags = {
    Name = var.service_tag
    Environment = var.environment_name
  }
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = "${aws_lb.front_end.arn}"
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.lb_tg.arn}"
  }
}
