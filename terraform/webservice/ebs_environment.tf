resource "aws_elastic_beanstalk_environment" "ebs-env" {
  depends_on = ["aws_elastic_beanstalk_application_version.ebs-app-ver"]
  name = "${var.service_name}-env-${var.environment_name}"
  application = "${aws_elastic_beanstalk_application.ebs-app.name}"
  solution_stack_name = "64bit Amazon Linux 2018.03 v2.7.4 running Java 8"
  cname_prefix = "${var.service_name}-env-${var.environment_name}"
  version_label = "${aws_elastic_beanstalk_application_version.ebs-app-ver.name}"

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name = "SERVER_PORT"
    value = "${var.application_port}"
  }
}
