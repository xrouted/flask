data "aws_ami" "amazon-linux-2" {
  most_recent = true
  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

resource "aws_network_interface" "interface" {
  subnet_id       = local.subnet_id
  security_groups = [aws_security_group.allow_tls.id]
}

resource "aws_instance" "ec2" {
  depends_on           = [aws_network_interface.interface]
  ami                  = data.aws_ami.amazon-linux-2.id
  instance_type        = local.instance_type
  user_data            = file("init.sh")
  iam_instance_profile = aws_iam_instance_profile.profile.name
  network_interface {
    network_interface_id = aws_network_interface.interface.id
    device_index         = 0
  }
}

resource "aws_security_group" "allow_tls" {
  name        = "${local.name}-allow-jenkins"
  description = "Allow Jenkins inbound traffic"
  vpc_id      = local.vpc_id
  ingress {
    description = "TLS from VPC"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [local.my_ip]
  }
  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    description      = "TLS from VPC"
    from_port        = 5000
    to_port          = 5000
    protocol         = "tcp"
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
}