resource "aws_launch_configuration" "launch_conf" {
  instance_type   = var.instance_type
  image_id        = var.ami_id
  security_groups = [aws_security_group.ec2_sg.id]
  name_prefix = "tf-${var.service_instance_name}-lc-"
  iam_instance_profile = aws_iam_instance_profile.instance_profile.id

  user_data = data.template_file.ec2_userdata.rendered

  lifecycle {
    create_before_destroy = false
  }
}
