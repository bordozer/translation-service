resource "aws_elastic_beanstalk_application_version" "ebs-app-ver" {
  depends_on = ["aws_elastic_beanstalk_application.ebs-app"]
  application = "${aws_elastic_beanstalk_application.ebs-app.name}"
  bucket = "artefacts-s3-bucket"
  key = "deployables/translation-service-1.1.jar"
  name = "v1"
}
