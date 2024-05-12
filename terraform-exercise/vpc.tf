resource "aws_vpc" "sage-vpc" {
  cidr_block = var.cidr

  tags = {
    Name = "sage-vpc"
  }
}

