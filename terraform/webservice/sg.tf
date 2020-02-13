resource "aws_security_group" "elb_sg" {
  name = "tf-${var.service_name}-elb-sg"

  vpc_id = "${var.vpc}"

  # Regular HTTP access for sitecore instance
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  # Access from ELB to everywhere
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
}

resource "aws_security_group" "ec2_sg" {
  name = "tf-${var.service_name}-ec2-sg"
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

/* SSH */
resource "aws_security_group_rule" "ec2_sg_rule_ssh" {
  security_group_id = "${aws_security_group.ec2_sg.id}"
  type            = "ingress"
  from_port       = "22"
  to_port         = "22"
  protocol        = "ssh"
  cidr_blocks     = "${var.white_ip}"
}

/* HTTP from ELB */
resource "aws_security_group_rule" "ec2_sg_rule_http" {
  security_group_id = "${aws_security_group.ec2_sg.id}"
  type            = "ingress"
  from_port       = "${var.app_port}"
  to_port         = "${var.app_port}"
  protocol        = "tcp"
  source_security_group_id = "${aws_security_group.elb_sg.id}"
}
