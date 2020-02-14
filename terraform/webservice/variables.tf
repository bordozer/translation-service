variable "service_name" {}
variable "service_tag" {}
variable "environment_name" {}

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

/*variable "availability_zone" {
  default = "eu-west-3a"
  description = "Comma separated list of EC2 availability zones to launch instances."
}
variable "subnets" {
  default = {
    "eu-west-3a" = "subnet-08d6e761"
    "eu-west-3b" = "subnet-f2d79f89"
    "eu-west-3c" = "subnet-096bf644"
  }
}*/

/* EC2 parameters */
variable "instance_type" { default = "t2.micro" }
variable "ami_id" {
  default = "ami-007fae589fdf6e955"
  description = "Amazon Linux 2 AMI (HVM), SSD Volume Type (64-bit x86)"
}
variable "ec2_instance_root_volume_type" { default = "gp2" }
variable "ec2_instance_root_volume_size" { default = "8" }

/* TODO: provide pub file as parameter */
variable "ssh_public_key_file_path" { default = "/home/blu/.ssh/aws/vgn-pub-key.pub" }

/* Application parameters */
variable "app_port" { default = 80 }
variable "app_health_check_uri" { default = "/" }
//variable "app_port" { default = 8977 }
//variable "app_health_check_uri" { default = "/health-check" }
variable "app_protocol" { default = "HTTP" }
variable "app_artefacts_s3_bucket" { default = "artefacts-s3-bucket" }
variable "app_artefact_name" { default = "translation-service-1.2.jar" }
