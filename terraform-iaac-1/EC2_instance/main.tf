resource "aws_instance" "ubuntu_server" {
  ami           = var.ubuntu_ami_id
  instance_type = "t2.micro"
  security_groups=["ssh_https"]
  key_name= var.key_name

  tags = {
    Name = "ubuntu-server"
  }
provisioner "local-exec" {
    command = "bash run_ansible_config.sh"
  }
}




