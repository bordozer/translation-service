provider "aws" {
  profile = "default"
  region = "${var.aws_region}"
}

resource "aws_instance" "example" {
  instance_type = "t2.micro"
  /* Amazon Linux 2 AMI (HVM), SSD Volume Type - ami-007fae589fdf6e955 (64-bit x86) */
  ami = "ami-007fae589fdf6e955"

  monitoring = false

  vpc_security_group_ids = ["sg-0d0c134d8c2c1d221"]
  availability_zone = "${var.aws_region}a"
}
