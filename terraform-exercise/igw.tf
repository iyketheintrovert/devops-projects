resource "aws_internet_gateway" "sage-igw" {
  vpc_id = aws_vpc.sage-vpc.id

  tags = {
    Name = "sage-igw"
  }
}