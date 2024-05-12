resource "aws_eip" "sage-eip" {
  domain = "vpc"
  tags = {
    Name = "nat"
  }
}

// Create NAT
resource "aws_nat_gateway" "sage-nat" {
  allocation_id = aws_eip.sage-eip.id
  subnet_id     = aws_subnet.sage-pub-subnets.id

  tags = {
    Name = "sage-nat"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.sage-igw]
}