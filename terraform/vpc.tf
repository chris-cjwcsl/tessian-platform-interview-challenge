resource "aws_vpc" "primary" {
  cidr_block = "10.0.0.0/16"
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "public" {
  count                   = 3
  cidr_block              = cidrsubnet(aws_vpc.primary.cidr_block, 8, 1 + count.index)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  vpc_id                  = aws_vpc.primary.id
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "internet_gateway" {
    vpc_id = aws_vpc.primary.id
}

resource "aws_route_table" "public" {
    vpc_id = aws_vpc.primary.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.internet_gateway.id
    }
}

resource "aws_route_table_association" "route_table_association" {
    count = 3
    subnet_id      = element(aws_subnet.public.*.id, count.index)
    route_table_id = aws_route_table.public.id
}
