resource "aws_iam_instance_profile" "instance_profile" {
  name = "tf-${var.service_instance_name}-instance-profile"
  role = aws_iam_role.service_iam_role.name
}

data "template_file" "ec2_userdata" {
  template = file("user_data.sh")
  vars = {
    t_service_name = var.service_name
    t_service_instance_name = var.service_instance_name
    t_env = var.environment_name
    t_app_dir = "/opt/${var.service_instance_name}"
    t_app_artefact_s3_bucket = var.app_artefacts_s3_bucket
    t_cmd_format = "export 'PS1=$${whoami}@$$(pwd) $ '"
  }
}
