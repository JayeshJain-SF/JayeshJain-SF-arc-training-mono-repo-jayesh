output "ec2_arn" {
  value = module.ec2.ec2_arn
}

output "vpc_id" {
  value = module.network.vpc_id
}

output "private_subnets" {
  value = module.network.private_subnets
}

output "public_subnets" {
    value = module.network.public_subnets
}

output "internet_gateway" {
    value = module.network.internet_gateway
  
}

output "rds_name" {
  value = module.rds.rds_name
}