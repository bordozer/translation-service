provider "aws" {
  profile = "default"
  region  = "${var.aws_region}"
}

resource "aws_instance" "example" {
  ami           = "ami-02ccb28830b645a41" /* Amazon Linux 2 AMI (HVM), SSD Volume Type - ami-02ccb28830b645a41 (64-bit x86) */
  instance_type = "t2.micro"
}
