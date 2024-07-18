data "aws_ami" "ami_id" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  tags = {
    Name = "Latest Amazon Linux 2"
  }
}

data "aws_vpc" "poc" {
  filter {
    name   = "tag:Name"
    values = ["arc-training-vpc"]
  }
}


data "aws_subnet" "poc" {
  filter {
    name   = "tag:Name"
    values = ["arc-training-public-subnet"]
  }
}