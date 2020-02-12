resource "aws_security_group" "ami_sg" {
  name = "tf-${var.service_name}-sg"
  description = "SG for EC2 instances which runs translator service"

  vpc_id = "${var.vpc}"

  # Access within this Security Group via TCP
  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    self = true
  }

  # Egress connections to Internet from Security Group
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
}

resource "aws_security_group_rule" "ami_sg_rule_http" {
  security_group_id = "${aws_security_group.ami_sg.id}"
  type            = "ingress"
  from_port       = 80
  to_port         = 80
  protocol        = "tcp"
  source_security_group_id = "${aws_security_group.elb_sg.id}"
}
