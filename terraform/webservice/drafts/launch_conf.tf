resource "aws_placement_group" "pgroup" {
  name     = "tf-${var.service_instance_name}-pg"
  strategy = "spread"
}

resource "aws_launch_configuration" "launch_conf" {
  instance_type   = "t2.micro"
  image_id        = var.ami_id
  security_groups = [aws_security_group.ec2_sg.id]
  name_prefix = "tf-${var.service_instance_name}-lc-"
  iam_instance_profile = "${aws_iam_instance_profile.instance_profile.id}"

  user_data = "${file("user_data.sh")}"

  lifecycle {
    create_before_destroy = var.create_before_destroy
  }
}
