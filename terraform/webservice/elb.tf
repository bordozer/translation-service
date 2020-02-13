resource "aws_elb" "elb" {
  name = "tf-${var.service_name}-elb"
  instances = [ "${aws_instance.ec2_instance.id}" ]
  cross_zone_load_balancing = true
  idle_timeout = 400
  connection_draining = true
  connection_draining_timeout = 400

  listener {
    instance_port = "${var.app_port}"
    instance_protocol = "${var.app_protocol}"

    lb_port = "80"
    lb_protocol = "http"
  }

//  health_check {
//    target = "${var.app_protocol}:${var.app_port}${var.app_health_check_uri}"
//    healthy_threshold = 2
//    unhealthy_threshold = 3
//    timeout = 2
//    interval = 60
//  }

  internal = false
  subnets = ["${lookup(var.subnets, var.availability_zone)}"]
  security_groups = [ "${aws_security_group.elb_sg.id}" ]

  tags = {
    Name = "${var.service_tag}"
  }
}
