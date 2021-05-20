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
