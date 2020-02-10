provider "aws" {
  profile = "default"
  region = "${var.aws_region}"
}

resource "aws_instance" "example" {
  instance_type = "${var.instance_type}"
  ami = "${var.ami_id}"

  monitoring = false

  vpc_security_group_ids = ["sg-0d0c134d8c2c1d221"] /* TODO: should not be accessible from web */
  availability_zone = "${var.availability_zone}"
  subnet_id = "${lookup(var.subnets, var.availability_zone)}"
  ebs_optimized = true
  associate_public_ip_address = true /* TODO: should be false, for test only */
//  iam_instance_profile = ""
  tags {
    Name = "tf-${var.service_name}"
  }
}
