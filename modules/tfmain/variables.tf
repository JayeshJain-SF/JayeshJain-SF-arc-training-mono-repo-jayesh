#################
# Create resource variables
#################

variable "create_security_group" {
  type = bool
  default = true
  description = "Boolen value to create security group resource"
}



variable "region" {
  type        = string
  default     = "us-east-1"
  description = "AWS region"
}

variable "project_name" {
  type        = string
  default     = "sourcefuse"
  description = "POC"
}

variable "ebs_block_device" {
  description = "EBS block devices to attach to the instance"
  type        = list(any)
  default     = []
}

variable "root_block_device" {
  type        = list(any)
  default     = []
}

variable "ingress_rules" {
  description = "list of ingress rules"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}
variable "egress_rules" {
  description = "list of egress rules"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}
variable "vpc_id" {
  type = string
  default = "vpc-0e1cb6bb04013bc49"

}


variable "subnet_id" {
  type = string
  default = "subnet-0740142a159982a63"
}


variable "sg_name" {
    type    = string
    description = "Name for Security group"
    default = "poc_sg"

}

# Network

variable "private_subnets" {
  description = "List of private subnets"
  type = list(object({
    name              = string
    availability_zone = string
    cidr_block        = string
  }))
}

variable "public_subnets" {
  description = "List of public subnets"
  type = list(object({
    name              = string
    availability_zone = string
    cidr_block        = string
    igw_id            = optional(string, "")
  }))
}

variable "vpc_cidr_block" {
  type = string
  default = "192.168.0.0/16"
}

#####################################
# RDS
#####################################

variable "username" {
  description = "Master RDS username"
  type        = string
  default     = "random"
}

variable "instance_class" {
  description = "instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "engine_version" {
  description = "engine version"
  type        = string
  default     = "8.0"
}


variable "engine" {
  description = "rds instance"
  type        = string
  default     = "mysql"
}


variable "allocated_storage" {
  description = "Allocate Storage value"
  type        = number
  default     = 20
}