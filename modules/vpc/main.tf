
################################################################################
## VPC
################################################################################
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr_block
  tags = {
    Name        = "arc-training-vpc"
    Environment = "arc_poc"
  }
}

################################################################################
## private
################################################################################
## subnet
resource "aws_subnet" "private" {
  for_each = { for x in var.private_subnets : x.name => x }

  vpc_id            = aws_vpc.vpc.id
  availability_zone = each.value.availability_zone
  cidr_block        = each.value.cidr_block

  tags = {
    Name        = "arc-training-private-subnet"
    Environment = "arc_poc"
  }
}

## route table
resource "aws_route_table" "private" {
  for_each = { for x in var.private_subnets : x.name => x }
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = "arc-training-route-table-private"
    Environment = "arc_poc"
  }
}

resource "aws_route" "private" {

  for_each = { for x in var.private_subnets : x.name => { public_subnet_name = replace(x.name, "-private-", "-public-") }}
  route_table_id         = aws_route_table.private[each.key].id
  nat_gateway_id         = aws_nat_gateway.public[each.value.public_subnet_name].id
  destination_cidr_block = "0.0.0.0/0"

  depends_on = [aws_route_table.private]
}

resource "aws_route_table_association" "private" {
  for_each = { for x in var.private_subnets : x.name => x }

  subnet_id      = aws_subnet.private[each.key].id
  route_table_id = aws_route_table.private[each.key].id

  depends_on = [
    aws_subnet.private,
    aws_route_table.private,
  ]
}

################################################################################
## public
################################################################################
## subnet
resource "aws_subnet" "public" {
  for_each = { for x in var.public_subnets : x.name => x }

  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = each.value.availability_zone
  cidr_block              = each.value.cidr_block


  tags = {
    Name        = "arc-training-public-subnet"
    Environment = "arc_poc"
  }
}

resource "aws_route_table" "public" {
  for_each = { for x in var.public_subnets : x.name => x }

  vpc_id = aws_vpc.vpc.id
  tags = {
    Name        = "arc-training-public-route-table"
    Environment = "arc_poc"
  }
}

resource "aws_route" "public" {
  for_each = { for x in var.public_subnets : x.name => x }

  route_table_id         = aws_route_table.public[each.key].id
  gateway_id             = aws_internet_gateway.igw.id 
  destination_cidr_block = "0.0.0.0/0"

  depends_on = [aws_route_table.public]
}

resource "aws_route_table_association" "public" {
  for_each = { for x in var.public_subnets : x.name => x }
  subnet_id      = aws_subnet.public[each.key].id
  route_table_id = aws_route_table.public[each.key].id

  depends_on = [
    aws_subnet.public,
    aws_route_table.public,
  ]
}

## elastic public ip
resource "aws_eip" "public" {
  for_each = { for x in var.public_subnets : x.name => x  }

  vpc = true
  tags = {
  Name        = "arc-training-eip"
  Environment = "arc_poc"
}
}

## nat gateway
resource "aws_nat_gateway" "public" {
  for_each = { for x in var.public_subnets : x.name => x }
  
  allocation_id = aws_eip.public[each.key].id
  subnet_id     = aws_subnet.public[each.key].id

   tags = {
    Name        = "arc-training-nat-gateway"
    Environment = "arc_poc"
  }

  depends_on = [aws_subnet.public]

}

###################################
# Internet gateway
##################################

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name        = "arc-training-internet-gateway"
    Environment = "arc_poc"
  }
}

