variable "ubuntu_ami_id"{
  type=string
  default="ami-00399ec92321828f5"
}
variable "key_name"{
}
output "public_ip" {
  value = aws_instance.ubuntu_server.public_ip
}
output "public_dns" {
  value = aws_instance.ubuntu_server.public_dns
}
