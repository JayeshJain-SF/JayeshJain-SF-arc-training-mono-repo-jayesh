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
  description = "set engine name"
  type        = string
  default     = "mysql"
}

variable "allocated_storage" {
  description = "Allocate Storage value"
  type        = number
  default     = 20
}