data "terraform_remote_state" "vpc" {

  backend = "s3"

  config {
    region = "${var.aws_region}"
    bucket = "${var.remote_state_s3_bucket}"
    key = "${var.remote_state_s3_key}"
    kms_key_id = "${var.remote_state_kms_key_id}"
    encrypt = "true"
  }
}
