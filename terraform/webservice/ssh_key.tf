resource "aws_key_pair" "ssh_key" {
  key_name = "aws-vgn-key-3"
  public_key = file("${var.ssh_public_key_file_path}")
}
