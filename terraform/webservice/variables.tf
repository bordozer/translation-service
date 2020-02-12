variable "service_name" {}
variable "environment_name" {}

variable "vpc" { default = "vpc-74c2c81d" }
variable "aws_region" { default = "eu-west-3" }
variable "instance_type" { default = "t2.micro" }
variable "ami_id" {
  default = "ami-007fae589fdf6e955"
  description = "Amazon Linux 2 AMI (HVM), SSD Volume Type (64-bit x86)"
}
variable "availability_zone" {
  default = "eu-west-3a"
  description = "Comma separated list of EC2 availability zones to launch instances."
}
variable "subnets" {
  default = {
    "eu-west-3a" = "subnet-08d6e761"
    "eu-west-3b" = "subnet-f2d79f89"
    "eu-west-3c" = "subnet-096bf644"
  }
}
variable "ec2_instance_root_volume_type" { default = "gp2" }
variable "ec2_instance_root_volume_size" { default = "8" }

variable "web_accessible_security_group_id" { default = "sg-0d0c134d8c2c1d221" }

variable "ec2_service_desired_count" { default = 1 }
variable "ec2_service_min_count" { default = 1 }
variable "ec2_service_max_count" { default = 1 }
variable "ec2_deployment_maximum_percent" { default = 100 }
variable "ec2_deployment_minimum_healthy_percent" { default = 0 }
variable "ec2_health_check_grace_period_seconds" { default = "60" }

variable "remote_state_s3_bucket" { default = "arn:aws:s3:::remote-state-bucket" }
variable "remote_state_kms_key_id" { default = "arn:aws:s3:::elasticbeanstalk-us-west-2-899415655760" }

variable "docker_image_tag" { default = "latest" }
variable "docker_registry" { default = "" } /* TODO */
variable "eureka_server_dns_name" { default = "" } /* TODO */

variable "app_java_opts_mem" { default = "-Xmx512m -Xms512m" }
variable "app_container_mem_limit_mb" { default = 300 }
variable "app_container_cpu_limit_units" { default = 200 }

/* TODO: provide pub file as parameter */
variable "ssh_public_key_file_path" { default = "/home/blu/.ssh/aws/vgn-pub-key.pub" }

variable rds_password {}
variable rds_db_name {}

variable "application_port" { default = 8977 }
