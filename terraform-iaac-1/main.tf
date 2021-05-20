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

module "security_groups" {
  source = "./security_groups"
}

module "ssh_keyfile" {
  source = "./ssh_keyfile"
}

module "template_based_conf" {
  source = "./template_based_conf"
  public_ip = module.EC2_instance.public_ip
  public_dns = module.EC2_instance.public_dns
  private_key_filename = module.ssh_keyfile.private_key_filename
}

module "EC2_instance" {
  source = "./EC2_instance"
  key_name = module.ssh_keyfile.key_name
}
