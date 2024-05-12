resource "aws_subnet" "sage-pub-subnets" {
  vpc_id                  = aws_vpc.sage-vpc.id
  cidr_block              = var.public_subnets.cidr_block
  availability_zone       = var.public_subnets.availability_zone
  map_public_ip_on_launch = var.public_subnets.map_public_ip_on_launch
}

resource "aws_subnet" "sage-priv-subnets" {
  vpc_id                  = aws_vpc.sage-vpc.id
  cidr_block              = var.private_subnets.cidr_block
  availability_zone       = var.private_subnets.availability_zone
  map_public_ip_on_launch = var.private_subnets.map_public_ip_on_launch
}
