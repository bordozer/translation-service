/*
data "terraform_remote_state" "cluster" {
  backend = "s3"
  config {
    region = "${var.aws_region}"

    bucket = "${var.s3_bucket}"
    key = "${var.s3_key}"

    encrypt = "true"
    kms_key_id = "${var.kms_key_id}"
  }
}
*/
