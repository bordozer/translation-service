resource "aws_lb" "front_end" {
  name = "tf-${var.service_instance_name}-lb"
  load_balancer_type = "application"
  subnets = var.subnets
  security_groups = [ "${aws_security_group.lb_sg.id}" ]

  internal = var.internal_lb_scheme
  enable_cross_zone_load_balancing = true
  idle_timeout = 60

  /*access_logs {
    bucket = "${var.lb_access_logs_s3_bucket}"
    prefix = "tf-${var.service_instance_name}-logs"
    enabled = true
  }*/

  tags = {
    Name = var.service_instance_name
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
