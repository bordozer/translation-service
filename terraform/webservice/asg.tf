resource "aws_autoscaling_group" "service_asg" {
  name                      = "tf-${var.service_instance_name}-asg"
  vpc_zone_identifier       = var.subnets
  placement_group           = aws_placement_group.pgroup.name
  min_size                  = 1
  desired_capacity          = 1
  max_size                  = 1
  health_check_grace_period = 360   # Time (in seconds) after instance comes into service before checking health
  health_check_type         = "ELB" # ELB or EC2
  min_elb_capacity          = 0
  wait_for_elb_capacity     = 0
  wait_for_capacity_timeout = 0

  launch_configuration      = aws_launch_configuration.launch_conf.name
  target_group_arns         = [aws_lb_target_group.lb_tg.arn]
//  load_balancers            = [aws_lb.front_end.name]

  lifecycle {
    create_before_destroy = false
  }

  timeouts {
    delete = "5m"
  }

//  tags = local.common_tags
}

resource "aws_placement_group" "pgroup" {
  name     = "tf-${var.service_instance_name}-pg"
  strategy = "spread"
}
