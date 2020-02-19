
variable "service_name" { default = "translator-service" }
variable "service_instance_name" {}
variable "environment_name" {}
variable "ssh_public_key_file_name" {}
variable "internal_lb_scheme" {}

/* Amazon account network parameters */
variable "vpc" { default = "vpc-74c2c81d" }
variable "aws_region" { default = "eu-west-3" }
variable "availability_zones" {
        default = [
          "eu-west-3a",
          "eu-west-3b",
          "eu-west-3c"
        ]
}
variable "subnets" {
  default = [
    "subnet-08d6e761",
    "subnet-f2d79f89",
    "subnet-096bf644"
  ]
}

/* EC2 parameters */
variable "instance_type" { default = "t2.micro" }
variable "ami_id" {
  default = "ami-007fae589fdf6e955"
  description = "Amazon Linux 2 AMI (HVM), SSD Volume Type (64-bit x86)"
}
variable "ec2_instance_root_volume_type" { default = "gp2" }
variable "ec2_instance_root_volume_size" { default = "8" }

/* Application parameters */
variable "app_port" { default = 8977 }
variable "app_health_check_uri" { default = "/health-check" }
variable "app_protocol" { default = "HTTP" }
variable "app_artefacts_s3_bucket" { default = "artefacts-s3-bucket" }
variable "app_artefact_name" { default = "translator-service.jar" }
