resource "aws_launch_configuration" "launch_conf" {
  instance_type   = "t2.micro"
  image_id        = var.ami_id
  security_groups = [aws_security_group.ec2_sg.id]
  name_prefix = "${var.service_name}-"
  iam_instance_profile = "${aws_iam_instance_profile.instance_profile.id}"

  user_data = "${file("user_data.sh")}"

  lifecycle {
    create_before_destroy = true
  }
}
