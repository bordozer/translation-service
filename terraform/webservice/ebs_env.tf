resource "aws_elastic_beanstalk_environment" "ebs-env" {
  depends_on = ["aws_elastic_beanstalk_application_version.ebs-app-ver"]
  name = "tf-${var.service_name}-env"
  application = "${aws_elastic_beanstalk_application.ebs-app.name}"
  solution_stack_name = "64bit Amazon Linux 2018.03 v2.10.2 running Java 8 "
  cname_prefix = "${var.service_name}-env"
  tier = "WebServer"
  version_label = "${aws_elastic_beanstalk_application_version.ebs-app-ver.name}"

  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = "${var.vpc}"
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = "${lookup(var.subnets, var.availability_zone)}"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name = "IamInstanceProfile"
    value = "aws-elasticbeanstalk-ec2-role"
//    value = "${aws_iam_instance_profile.instance_profile.name}"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name = "SecurityGroups"
    value = "${aws_security_group.ec2_sg.id}"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name = "SERVER_PORT"
    value = "${var.app_port}"
  }

  setting {
    namespace = "aws:ec2:vpc"
    name = "AssociatePublicIpAddress"
    value = "false"
  }

  tags = {
    Name = "${var.service_tag}"
  }
}
