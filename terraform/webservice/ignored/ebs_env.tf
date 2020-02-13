resource "aws_elastic_beanstalk_environment" "ebs-env" {
  depends_on = ["aws_elastic_beanstalk_application_version.ebs-app-ver"]
  name = "tf-${var.service_name}-env"
  application = "${aws_elastic_beanstalk_application.ebs-app.name}"
  solution_stack_name = "64bit Amazon Linux 2018.03 v2.10.2 running Java 8 "
  cname_prefix = "${var.service_name}-env"
  tier = "WebServer"
  version_label = "${aws_elastic_beanstalk_application_version.ebs-app-ver.name}"

  # VPC settings
  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = "${var.vpc}"
  }
  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = "${lookup(var.subnets, var.availability_zone)}"
//    value = "${join(",", var.elb_subnets)}"
  }
  setting {
    namespace = "aws:ec2:vpc"
    name = "ELBSubnets"
    value = "${join(",", var.subnets)}"
  }
  setting {
    namespace = "aws:ec2:vpc"
    name = "AssociatePublicIpAddress"
    value = "false"
  }
  setting {
    namespace = "aws:ec2:vpc"
    name = "ELBScheme"
    value = "public"
  }

  # ELB settings
  setting {
    namespace = "aws:elb:loadbalancer"
    name = "CrossZone"
    value = "true"
  }
  setting {
    namespace = "aws:elb:loadbalancer"
    name = "SecurityGroups"
    value = "${aws_security_group.elb_sg.id}"
  }
  setting {
    namespace = "aws:elb:loadbalancer"
    name = "ManagedSecurityGroup"
    value = "${aws_security_group.elb_sg.id}"
  }
  setting {
    namespace = "aws:elb:loadbalancer"
    name = "LoadBalancerHTTPPort"
    value = "80"
  }
  setting {
    namespace = "aws:elb:listener"
    name = "ListenerProtocol"
    value = "HTTP"
  }
  setting {
    namespace = "aws:elb:listener"
    name = "InstanceProtocol"
    value = "HTTP"
  }
  setting {
    namespace = "aws:elbv2:loadbalancer"
    name = "AccessLogsS3Enabled"
    value = "true"
  }
  setting {
    namespace = "aws:elbv2:loadbalancer"
    name = "AccessLogsS3Bucket"
    value = "${var.artefacts_s3_bucket}" /* TODO: create a ceparate bucket */
  }

  # General Beanstalk settings
  setting {
    namespace = "aws:elasticbeanstalk:command"
    name = "BatchSize"
    value = "30"
  }
  setting {
    namespace = "aws:elasticbeanstalk:command"
    name = "BatchSizeType"
    value = "Percentage"
  }
  setting {
    namespace = "aws:elasticbeanstalk:hostmanager"
    name = "LogPublicationControl"
    value = "true"
  }
  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name = "ServiceRole"
    value = "aws-elasticbeanstalk-service-role"
  }

  # Auto-scaling (EC2 instance) settings
  setting {
    namespace = "aws:autoscaling:asg"
    name = "Availability Zones"
    value = "Any 2"
  }
  setting {
    namespace = "aws:autoscaling:asg"
    name = "MinSize"
    value = "1"
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name = "IamInstanceProfile"
    value = "arn:aws:iam::899415655760:role/aws-elasticbeanstalk-ec2-role"
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name = "SecurityGroups"
    value = "${aws_security_group.ec2_sg.id}"
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name = "EC2KeyName"
    value = "${aws_key_pair.ssh_key.id}"
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name = "InstanceType"
    value = "t2.micro"
  }
  setting {
    namespace = "aws:autoscaling:updatepolicy:rollingupdate"
    name = "RollingUpdateType"
    value = "Health"
  }

  # Health reporting
  setting {
    namespace = "aws:elasticbeanstalk:healthreporting:system"
    name = "SystemType"
    value = "enhanced"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name = "SERVER_PORT"
    value = "${var.app_port}"
  }

  tags = {
    Name = "${var.service_tag}"
  }
}
