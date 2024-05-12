resource "aws_route_table" "sage-pubrt" {
  vpc_id = aws_vpc.sage-vpc.id

  route {
    cidr_block = var.route_tables.cidr_block
    gateway_id = aws_internet_gateway.sage-igw.id
  }

  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table" "sage-privrt" {
  vpc_id = aws_vpc.sage-vpc.id

  route {
    cidr_block = var.route_tables.cidr_block
    gateway_id = aws_nat_gateway.sage-nat.id
  }

  tags = {
    Name = "private-route-table"
  }
}



// Route Table Association Public
resource "aws_route_table_association" "sage-pubrta" {
  subnet_id      = aws_subnet.sage-pub-subnets.id
  route_table_id = aws_route_table.sage-pubrt.id

  depends_on = [
    aws_subnet.sage-pub-subnets
  ]
}

// Route Table Association Private
resource "aws_route_table_association" "sage-privrta" {
  subnet_id      = aws_subnet.sage-priv-subnets.id
  route_table_id = aws_route_table.sage-privrt.id

  depends_on = [
    aws_subnet.sage-priv-subnets
  ]
}