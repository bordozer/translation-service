resource "aws_elastic_beanstalk_application" "ebs-app" {
  name = "tf-${var.service_name}-app"
  description = "${var.service_name} application"
  appversion_lifecycle {
    service_role = "arn:aws:iam::899415655760:role/aws-elasticbeanstalk-service-role"
    max_count = 3
    delete_source_from_s3 = true
  }
}
