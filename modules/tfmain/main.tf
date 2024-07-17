################################################################################
## defaults
################################################################################
terraform {
  required_version = "~> 1.3"

  required_providers {
    aws = {
      version = "~> 4.0"
      source  = "hashicorp/aws"
    }
  }

  #backend "s3" {}
}


provider "aws" {
  region = var.region
}

############################################################################
## EC2
###########################################################################
module "ec2" {
  source            = "../ec2"
  ami_id            = data.aws_ami.ami_id.id
  instance_type     = var.instance_type
  vpc_id            = data.aws_vpc.poc.id
  subnet_id         = data.aws_subnet.poc.id
  ingress_rules     = var.ingress_rules
  ebs_block_device  = var.ebs_block_device
  egress_rules      = var.egress_rules
  root_block_device = var.root_block_device
  sg_name           = var.sg_name
  depends_on        = [module.network]
}


module "network" {
  source = "../vpc"

  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  vpc_cidr_block  = var.vpc_cidr_block
}

module "rds" {
  source = "../rds"

  username          = var.username
  instance_class    = var.instance_class
  engine            = var.engine
  engine_version    = var.engine_version
  allocated_storage = var.allocated_storage

}

