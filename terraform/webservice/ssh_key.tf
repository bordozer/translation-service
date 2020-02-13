resource "aws_key_pair" "ssh_key" {
  key_name = "vgn-pub-key"
  public_key = file("${var.ssh_public_key_file_path}")
}
