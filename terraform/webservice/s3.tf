resource "aws_s3_bucket_object" "artefact_upload" {
  bucket = var.app_artefacts_s3_bucket
  key = "tf-${var.service_instance_name}.jar"
  source = "../../build/libs/${var.app_artefact_name}"
}

// https://docs.aws.amazon.com/elasticloadbalancing/latest/classic/enable-access-logs.html
// 009996457667 is 'eu-west-3'
// https://github.com/jetbrains-infra/terraform-aws-s3-bucket-for-logs/blob/master/s3.tf
/*resource "aws_s3_bucket" "app_log_bucket" {
  bucket = "tf-${var.service_instance_name}-logs"
  acl    = "private"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::009996457667:root"
      },
      "Action": "s3:PutObject",
      "Resource": "arn:aws:s3:::tf-${var.service_instance_name}-logs*//*"
    }
  ]
}
EOF

  tags = {
    Name = var.service_instance_name
    Environment = var.environment_name
    ServiceName = var.service_name
  }
}*/
