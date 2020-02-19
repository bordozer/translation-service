resource "aws_instance" "ec2_instance" {

  instance_type = "${var.instance_type}"
  ami = "${var.ami_id}"

  root_block_device {
    volume_type = "${var.ec2_instance_root_volume_type}"
    volume_size = "${var.ec2_instance_root_volume_size}"
  }

  monitoring = false
  vpc_security_group_ids = ["${aws_security_group.ec2_sg.id}"]
  availability_zone = element(var.availability_zones, 0)
  subnet_id = element(var.subnets, 0)
  associate_public_ip_address = true
  iam_instance_profile = "${aws_iam_instance_profile.instance_profile.id}"

  key_name = "${aws_key_pair.ssh_key.id}"

  lifecycle {
    create_before_destroy = var.create_before_destroy
  }
  user_data = "${file("user_data.sh")}"

  tags = {
    Name = var.service_instance_name
    Environment = var.environment_name
    ServiceName = var.service_name
    AppArtefactS3Bucket = var.app_artefacts_s3_bucket
    AppArtefactFileName = "tf-${var.service_instance_name}.jar"
  }
}
