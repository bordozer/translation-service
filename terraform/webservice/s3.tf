resource "aws_s3_bucket_object" "artefact_upload" {
  bucket = "${var.app_artefacts_s3_bucket}"
  key = "${var.environment_name}/tf-${var.service_name}.jar"
  source = "../../build/libs/${var.app_artefact_name}"
}

/*resource "aws_s3_bucket" "lb_logs" {
  bucket = "tf-${var.service_name}-lb-logs"
  acl = "private"

  tags = {
    Name = var.service_tag
    Environment = var.environment_name
  }
}*/
