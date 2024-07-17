output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "private_subnets" {
value = [ for subnet in aws_subnet.private : subnet.arn ]
}

output "public_subnets" {
value = [ for subnet in aws_subnet.public : subnet.arn ]
}

output "internet_gateway" {
    value = aws_internet_gateway.igw.arn
  
}

