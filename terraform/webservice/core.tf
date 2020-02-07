terraform {
  backend "s3" {
    bucket = "remote-state-bucket"
    key = "terraform.tfstate"
    region = "us-west-2"
  }
}
