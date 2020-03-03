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

  tags = local.common_tags
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
