resource "aws_instance" "translator-service" {

  instance_type = "${var.instance_type}"
  ami = "${var.ami_id}"

  root_block_device {
    volume_type = "${var.ec2_instance_root_volume_type}"
    volume_size = "${var.ec2_instance_root_volume_size}"
  }

  monitoring = false

  vpc_security_group_ids = ["${var.web_accessible_security_group_id}"]
  availability_zone = "${var.availability_zone}"
  subnet_id = "${lookup(var.subnets, var.availability_zone)}"
  associate_public_ip_address = true /* TODO: should be false, for test only */
  //  iam_instance_profile = ""
}
