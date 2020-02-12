variable "app_port" { default = "80" }
variable "app_protocol" { default = "http" }
variable "app_health_check_uri" { default = "/health-check" }

resource "aws_elb" "elb" {
  name = "tf-${var.service_name}"

  instances = [ "${aws_instance.translator-service-ami-instance.id}" ]
  connection_draining = true
  connection_draining_timeout = 120

  listener {
    instance_port = "${var.app_port}"
    instance_protocol = "${var.app_protocol}"

    lb_port = "${var.app_port}"
    lb_protocol = "${var.app_protocol}"
  }

  health_check {
    target = "${var.app_protocol}:${var.app_port}${var.app_health_check_uri}"
    healthy_threshold = 2
    unhealthy_threshold = 3
    timeout = 2
    interval = 30
  }

  internal = false
  subnets = ["${lookup(var.subnets, var.availability_zone)}"]
  security_groups = [ "${aws_security_group.elb_sg.id}" ]
}

resource "aws_security_group" "elb_sg" {
  name = "tf-${var.service_name}-elb-sg"

  vpc_id = "${var.vpc}"

  # Regular HTTP access for sitecore instance
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  # Access from ELB to everywhere
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
}
