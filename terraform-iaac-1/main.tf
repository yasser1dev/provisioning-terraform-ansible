terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "us-east-2"
}

resource "aws_security_group" "allow_https_ssh"{
  name="ssh_https"
  description="allow https and ssh"
  vpc_id=var.default_vpc_id

  ingress{
    from_port="443"
    to_port="443"
    protocol="tcp"	
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress{
    from_port="22"
    to_port="22"
    protocol="tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  
  ingress{
    from_port="81"
    to_port="81"
    protocol="tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress{
    from_port="80"
    to_port="80"
    protocol="tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "https_ssh"
 }


}

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
resource "local_file" "ansible_inventory" {
  content = templatefile("inventory.tmpl", {
      ip          = aws_instance.ubuntu_server.public_ip,
      ssh_keyfile = local_file.private_key.filename
  })
  filename = format("%s/%s", abspath(path.root), "inventory.yaml")
}

resource "local_file" "ssl_subject_alt_ip" {
  content = templatefile("~/self-provisioning/roles/ssl-certificate-generation/vars/main.tmpl", {
      ip          = aws_instance.ubuntu_server.public_ip
  })
  filename = format("%s/%s",abspath(path.root),"main.yml")
}
   

resource "local_file" "conf_server_name" {
  content = templatefile("~/static_website_files/web-site1.tmpl", {
     public_dns          = aws_instance.ubuntu_server.public_dns
  })
  filename = format("%s/%s",abspath(path.root),"web-site1")
}
resource "aws_instance" "ubuntu_server" {
  ami           = var.ubuntu_ami_id
  instance_type = "t2.micro"
  security_groups=["ssh_https"]
  key_name= aws_key_pair.aws_key.key_name

  tags = {
    Name = "ubuntu-server"
  }
provisioner "local-exec" {
    command = "bash run_ansible_config.sh"
  }
}




