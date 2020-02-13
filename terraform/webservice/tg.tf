resource "aws_lb_target_group" "instance" {
  name     = "tf-${var.service_name}-tg"
  target_type = "instance"
  protocol = "HTTP"
  port     = "${var.app_port}"
  vpc_id   = "${var.vpc}"

  health_check {
    protocol = "${var.app_protocol}"
    port = "${var.app_port}"
    path = "${var.app_health_check_uri}"
    healthy_threshold = 2
    unhealthy_threshold = 3
    timeout = 2
    interval = 60
  }

  tags = {
    Name = "${var.service_tag}"
  }
}

resource "aws_lb_target_group_attachment" "test" {
  target_group_arn = "${aws_lb_target_group.instance.arn}"
  target_id        = "${aws_instance.ec2_instance.id}"
  port             = 80
}
