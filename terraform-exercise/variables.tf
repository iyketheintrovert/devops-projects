variable "region" {
  type = string
}

variable "cidr" {
  type        = string
  description = "The vpc"
}

variable "public_subnets" {
  type = object({
    cidr_block              = string
    availability_zone       = string
    map_public_ip_on_launch = bool
  })
  description = "The public subnets"
}

variable "private_subnets" {
  type = object({
    cidr_block              = string
    availability_zone       = string
    map_public_ip_on_launch = bool
  })
  description = "The private subnets"
}

variable "route_tables" {
  type        = map(string)
  description = "Route tables for subnets"
}
