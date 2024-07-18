
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
    name                    = string
    availability_zone       = string
    cidr_block              = string
    igw_id                  = optional(string, "")
  }))
}

variable "vpc_cidr_block" {
  type = string
}