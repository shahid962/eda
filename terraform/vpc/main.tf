resource "aws_vpc" "vpc" {
  cidr_block           = var.vpccidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge(var.tags,
    {
      Name = "Shahid-eda-vpc"
    }
  )

}

resource "aws_subnet" "pub_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.pubcidr
  availability_zone       = var.az1
  map_public_ip_on_launch = true
  tags = merge(var.tags,
    {
      Name = "Shahid-eda-pub-subnet"
    }
  )

}

resource "aws_subnet" "pvt_subnet" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.pvtcidr
  availability_zone = var.az2
  tags = merge(var.tags,
    {
      Name = "Shahid-eda-pvt-subnet"
    }
  )

}

resource "aws_internet_gateway" "eda_igw" {
  vpc_id = aws_vpc.vpc.id
  tags = merge(var.tags,
    {
      Name = "Shahid-eda-igw"
    }
  )

}
#Create Route Table
resource "aws_route_table" "pub_rt" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.eda_igw.id
  }
  tags = merge(var.tags,
    {
      Name = "Shahid-eda-pub-rt"
    }
  )

}
#Create Route Table Association
resource "aws_route_table_association" "rt_association" {
  subnet_id      = aws_subnet.pub_subnet.id
  route_table_id = aws_route_table.pub_rt.id
}
# Create EIP
resource "aws_eip" "eda_eip" {
  domain = "vpc"
  tags = merge(var.tags,
    {
      Name = "Shahid-eda-eip"
    }
  )

}
# Create NAT Gateway
resource "aws_nat_gateway" "eda_nat_gw" {
  allocation_id = aws_eip.eda_eip.id
  subnet_id     = aws_subnet.pub_subnet.id
  tags = merge(var.tags,
    {
      Name = "Shahid-eda-nat-gw"
    }
  )
}

# Create Route Table for route table for private subnet
resource "aws_route" "private_route" {
  route_table_id         = aws_vpc.vpc.default_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.eda_nat_gw.id
}
