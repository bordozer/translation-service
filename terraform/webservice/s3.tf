resource "aws_s3_bucket_object" "artefact_upload" {
  bucket = "${var.artefacts_s3_bucket}"
  key    = "${var.environment_name}/tf-${var.service_name}.jar"
  source = "../../build/libs/${var.app_artefact_name}"
}
