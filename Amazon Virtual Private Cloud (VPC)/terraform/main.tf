provider "aws" {
      region     = "${var.region}"
      access_key = "${var.access_key}"
      secret_key = "${var.secret_key}"

     default_tags {
       tags = {
         Environment     = "Prod"
         Service         = "Terraform"
    }
  }

}


# VPC resources: This will create 1 VPC with 4 Subnets, 1 Internet Gateway, 4 Route Tables. 

resource "aws_vpc" "terraform-vpc" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
      Name = "terraform-vpc"
  }
}

resource "aws_internet_gateway" "terraform-vpc" {
  vpc_id = aws_vpc.terraform-vpc.id

  tags = {
      Name = "terraform-vpc-ig"
  }
}

resource "aws_route_table" "private" {
  count = length(var.private_subnet_cidr_blocks)

  vpc_id = aws_vpc.terraform-vpc.id

  tags = {
      Name = "terraform-vpc-rt-pvt"
  }
}

# resource "aws_route" "private" {
#   count = length(var.private_subnet_cidr_blocks)

#   route_table_id         = aws_route_table.private[count.index].id
#   destination_cidr_block = "0.0.0.0/0"
#   nat_gateway_id         = aws_nat_gateway.terraform-vpc[count.index].id
# }

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.terraform-vpc.id

  tags = {
      Name = "terraform-vpc-rt-pub"
  }
}

resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.terraform-vpc.id
}

resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidr_blocks)

  vpc_id            = aws_vpc.terraform-vpc.id
  cidr_block        = var.private_subnet_cidr_blocks[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
      Name = "terraform-vpc-sub-pvt"
  }
}

resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidr_blocks)

  vpc_id                  = aws_vpc.terraform-vpc.id
  cidr_block              = var.public_subnet_cidr_blocks[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true

  tags = {
      Name = "terraform-vpc-sub-pub"
  }
}

resource "aws_route_table_association" "private" {
  count = length(var.private_subnet_cidr_blocks)

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}

resource "aws_route_table_association" "public" {
  count = length(var.public_subnet_cidr_blocks)

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}


# NAT resources: This will create 2 NAT gateways in 2 Public Subnets for 2 different Private Subnets.

# resource "aws_eip" "nat" {
#   count = length(var.public_subnet_cidr_blocks)

#   vpc = true
# }

# resource "aws_nat_gateway" "terraform-vpc" {
#   depends_on = [aws_internet_gateway.terraform-vpc]

#   count = length(var.public_subnet_cidr_blocks)

#   allocation_id = aws_eip.nat[count.index].id
#   subnet_id     = aws_subnet.public[count.index].id

#   tags = {
#       Name = "terraform-vpc-ng"
#   }
# }