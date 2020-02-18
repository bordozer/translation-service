resource "aws_launch_configuration" "launch_conf" {
  instance_type   = "t2.micro"
  image_id        = var.ami_id
  security_groups = [aws_security_group.ec2_sg.id]
  name_prefix = "tf-${var.service_instance_name}-"
  iam_instance_profile = "${aws_iam_instance_profile.instance_profile.id}"

  user_data = "${file("user_data.sh")}"

  lifecycle {
    create_before_destroy = true
  }
}

/*resource "aws_autoscaling_group" "api-autoscaling" {
  name = "tf-${aws_launch_configuration.launch_conf.name}-asg"

  vpc_zone_identifier  = var.subnets
  launch_configuration = "${aws_launch_configuration.launch_conf.name}"
  min_size             = 1
  desired_capacity     = 1
  max_size             = 2
  health_check_grace_period = 300
  health_check_type = "EC2"
  load_balancers = ["${aws_lb.front_end.name}"]
  force_delete = true

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = var.service_instance_name
    Environment = var.environment_name
  }
}*/
