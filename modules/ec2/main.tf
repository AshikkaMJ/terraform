

# Get the latest Ubuntu AMI for the selected region
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical (official Ubuntu)

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Security group allowing SSH access (port 22) and all outbound traffic
resource "aws_security_group" "ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound and all outbound traffic"

  ingress {
    description = "SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # ⚠️ For security, replace with your IP like "x.x.x.x/32"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 instance using Ubuntu AMI and the SSH security group
resource "aws_instance" "my_ec2" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.ssh.id]
  associate_public_ip_address = true  # Ensure it gets a public IP

  tags = {
    Name = "MyEC2"
  }
}
