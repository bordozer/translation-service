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

  tags = {
    Name = "${var.service_tag}"
  }
}

resource "aws_security_group" "ec2_sg" {
  name = "tf-${var.service_name}-ec2-sg"
  description = "SG for EC2 instances which runs translator service"

  vpc_id = "${var.vpc}"

  # Access within this Security Group via TCP
//  ingress {
//    from_port = 0
//    to_port = 0
//    protocol = "-1"
//    self = true
//  }

  # Egress connections to Internet from Security Group
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  tags = {
    Name = "${var.service_tag}"
  }
}

resource "aws_security_group_rule" "ec2_sg_rule_ssh" {
  security_group_id = "${aws_security_group.ec2_sg.id}"
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = [ "0.0.0.0/0" ]
  description       = "SSH access"
}

/* HTTP from ELB */
resource "aws_security_group_rule" "ec2_sg_rule_http" {
  security_group_id = "${aws_security_group.ec2_sg.id}"
  type            = "ingress"
  from_port       = var.app_port
  to_port         = var.app_port
  protocol        = "tcp"
  source_security_group_id = "${aws_security_group.elb_sg.id}"
  description       = "ELB access"
}

/*
// TODO
https://github.com/joshuamkite/terraform-aws-ssh-bastion-service/blob/master/security_group.tf
data "aws_subnet" "lb_subnets" {
  count = length(var.subnets_lb)
  id    = var.subnets_lb[count.index]
}

resource "aws_security_group_rule" "lb_healthcheck_in" {
  security_group_id = aws_security_group.bastion_service.id
  cidr_blocks       = data.aws_subnet.lb_subnets.*.cidr_block
  from_port         = var.lb_healthcheck_port
  to_port           = var.lb_healthcheck_port
  protocol          = "tcp"
  type              = "ingress"
  description       = "access from load balancer CIDR ranges for healthchecks"
}

*/
