resource "aws_s3_bucket_object" "artefact_upload" {
  bucket = "${var.app_artefacts_s3_bucket}"
  key = "tf-${var.service_instance_name}.jar"
  source = "../../build/libs/${var.app_artefact_name}"
}
