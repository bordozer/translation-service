variable "service_name" {}
variable "environment_name" {}

variable "aws_region" { default = "us-east-2" }

variable "ec2_service_desired_count" { default = 1 }
variable "ec2_service_min_count" { default = 1 }
variable "ec2_service_max_count" { default = 1 }
variable "ec2_deployment_maximum_percent" { default = 100 }
variable "ec2_deployment_minimum_healthy_percent" { default = 0 }
variable "ec2_health_check_grace_period_seconds" { default = "60" }

variable "remote_state_s3_bucket" { default = "arn:aws:s3:::remote-state-bucket" }
//variable "remote_state_s3_key" {}
variable "remote_state_kms_key_id" { default = "arn:aws:s3:::elasticbeanstalk-us-west-2-899415655760" }

variable "docker_image_tag" { default = "latest" }
variable "eureka_server_dns_name" { default = "" } /* TODO */
variable "docker_registry" { default = "" } /* TODO */

variable "app_java_opts_mem" { default = "-Xmx512m -Xms512m" }
variable "app_container_mem_limit_mb" { default = 300 }
variable "app_container_cpu_limit_units" { default = 200 }
