resource "aws_autoscaling_group" "heavy" {
  name                      = "tf-heavy-asg"
  vpc_zone_identifier       = var.subnets
  desired_capacity          = 1
  min_size                  = 1
  max_size                  = 1
  health_check_grace_period = 360
  health_check_type         = "EC2"
  min_elb_capacity          = 0 # 0 skips waiting for instances attached to the load balancer
  wait_for_capacity_timeout = "0m" # 0 disables wait for ASG capacity
  launch_configuration      = "${aws_launch_configuration.launch_conf.name}"
  load_balancers            = ["${aws_elb.heavy.name}"]

  tag {
    key                 = "Name"
    value               = "heavy-web"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = false
  }
}
