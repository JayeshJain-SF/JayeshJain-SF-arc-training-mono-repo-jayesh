#################
# Create resource variables
#################

variable "create_security_group" {
  type        = bool
  default     = true
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
  type    = list(any)
  default = []
}

variable "root_block_device" {
  type    = list(any)
  default = []
}

variable "ingress_rules" {
  description = "A list of ingress rules"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}
variable "egress_rules" {
  description = "A list of egress rules"
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

}

variable "ami_id" {
  type = string

}

variable "subnet_id" {
  type = string
}



variable "sg_name" {
  type        = string
  description = "Name for Security group"

}
