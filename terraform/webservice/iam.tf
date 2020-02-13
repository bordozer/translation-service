resource "aws_iam_role" "service_iam_role" {
  name = "tf-${var.service_name}-iam-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
    Name = "${var.service_tag}"
  }
}

resource "aws_iam_role_policy" "service-full-access-policy" {
  name = "tf-${var.service_name}-access-policy"
  role = "${aws_iam_role.service_iam_role.id}"
  policy = <<EOF
{
  "Statement": [{
    "Effect": "Allow",
    "Action": [
      "*"
    ],
    "Resource": "*"
  }]
}
EOF
}

resource "aws_iam_instance_profile" "instance_profile" {
  name = "tf-${var.service_name}-instance-profile"
  role = "${aws_iam_role.service_iam_role.name}"
}
