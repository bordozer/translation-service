resource "aws_elastic_beanstalk_application_version" "ebs-app-ver" {
  depends_on = ["aws_elastic_beanstalk_application.ebs-app"]
  name = "tf-v1"
  application = "${aws_elastic_beanstalk_application.ebs-app.name}"
  description = "${var.service_name} application version created by terraform"
  bucket = "${var.artefacts_s3_bucket}"
  key = "${var.app_artefact_name}"

  tags = {
    Name = "${var.service_tag}"
  }
}
