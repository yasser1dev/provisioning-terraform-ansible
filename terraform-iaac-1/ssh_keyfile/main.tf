resource "tls_private_key" "key" {
 algorithm = "RSA"
 rsa_bits  = 4096
}
 
resource "aws_key_pair" "aws_key" {
 key_name   = "ubuntu-server-ssh-key"
 public_key = tls_private_key.key.public_key_openssh
}

resource "local_file" "private_key" {
  sensitive_content = tls_private_key.key.private_key_pem
  filename          = format("%s/%s/%s", abspath(path.root), ".ssh", "ubuntu-ssh-key.pem")
  file_permission   = "0600"
}
