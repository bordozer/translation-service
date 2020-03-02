resource "aws_iam_instance_profile" "instance_profile" {
  name = "tf-${var.service_instance_name}-instance-profile"
  role = aws_iam_role.service_iam_role.name
}

resource "aws_iam_role" "service_iam_role" {
  name = "tf-${var.service_instance_name}-iam-role"

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
    Name = var.service_instance_name
    Environment = var.environment_name
    ServiceName = var.service_name
  }
}

resource "aws_iam_role_policy" "service_full_access_policy" {
  name = "tf-${var.service_instance_name}-access-policy"
  role = aws_iam_role.service_iam_role.id
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
