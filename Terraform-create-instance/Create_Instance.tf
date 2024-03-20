# Selecting AWS as provider and choosing region from select_region variable
provider "aws" {
  region = var.select_region
}

# Creating a variable select_region 
variable "select_region" {
  default = "us-east-1"
}

# Creating a key pair using ssh-keygen and giving the path of key
resource "aws_key_pair" "flask-app-kp" {
  key_name   = "flask-app-key-pair"
  public_key = file("C:/Users/ROSHA/.ssh/id_rsa.pub")
}

# Selecting latest ami with hvm as virtualization-type and x86_64 as architecture
data "aws_ami" "latest_ami" {
  most_recent = true
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  owners = ["amazon"]
}

# Creating an EC2 Instance with ami, kp, instance type and assign public ip add
resource "aws_instance" "ec2_instance" {
  ami                         = data.aws_ami.latest_ami.id
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  tags = {
    Name = "flask-app"
  }
  security_groups = ["flask-app"]
  key_name        = aws_key_pair.flask-app-kp.key_name
}

# Creating aws kms key
resource "aws_kms_key" "flask_app_kms" {
      deletion_window_in_days = 7
}

# Creating EBS volume and attaching the KMS 
resource "aws_ebs_volume" "encrypt_ebs_volume" {
  availability_zone = aws_instance.ec2_instance.availability_zone
  size              = 10
  encrypted         = true
  kms_key_id = aws_kms_key.flask_app_kms.arn
  tags = {
    Name = "EBS_Encrypted_Volume"
  }
}

# Attaching EBS volume with KMS encrypted to the instance
resource "aws_volume_attachment" "attach_volume_with_kms" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.encrypt_ebs_volume.id
  instance_id = aws_instance.ec2_instance.id
}