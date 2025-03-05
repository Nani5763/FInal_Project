# Create VPC
resource "aws_vpc" "three-tier" {
    cidr_block = "172.21.0.0/16"
    enable_dns_hostnames = true
    enable_dns_support = true
    tags = {
      Name = "3-tier-vpc"
    }
  
}
# For Frontend LoadBalancer
resource "aws_subnet" "public-subnet-1" {
    vpc_id = aws_vpc.three-tier.id
    cidr_block = "172.21.1.0/24"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true  # for auto asign public ip for subnet
    tags = {
      Name = "pub-sub-1a"
    }
  
}

# For Frontend LoadBalancer
resource "aws_subnet" "public-subnet-2" {
    vpc_id = aws_vpc.three-tier.id
    cidr_block = "172.21.2.0/24"
    availability_zone = "us-east-1b"
    map_public_ip_on_launch = true # for auto asign public ip for subnet
    tags = {
      Name = "pub-sub-2b"
    }
  
}

# frontend server
resource "aws_subnet" "private-subnet-3" {
    vpc_id = aws_vpc.three-tier.id
    cidr_block = "172.21.3.0/24"
    availability_zone = "us-east-1a"
    tags = {
      Name = "pvt-3a"
    }
  
}
# frontend server
resource "aws_subnet" "private-subnet-4" {
    vpc_id = aws_vpc.three-tier.id
    cidr_block = "172.21.4.0/24"
    availability_zone = "us-east-1b"
    tags = {
        Name = "pvt-4b"
    }
  
}
# Backend server
resource "aws_subnet" "private-subnet-5" {
    vpc_id = aws_vpc.three-tier.id
    cidr_block = "172.21.5.0/24"
    availability_zone = "us-east-1a"
    tags = {
      Name = "pvt-5a"
    }
  
}
# Backend server
resource "aws_subnet" "private-subnet-6" {
    vpc_id = aws_vpc.three-tier.id
    cidr_block = "172.21.6.0/24"
    availability_zone = "us-east-1b"
    tags = {
      Name = "pvt-6b"
    }
  
}
# RDS server
resource "aws_subnet" "private-subnet-7" {
    vpc_id = aws_vpc.three-tier.id
    cidr_block = "172.21.7.0/24"
    availability_zone = "us-east-1a"
    tags = {
      Name = "pvt-7a"
    }
  
}
# RDS server
resource "aws_subnet" "private-subnet-8" {
    vpc_id = aws_vpc.three-tier.id
    cidr_block = "172.21.8.0/24"
    availability_zone = "us-east-1b"
    tags = {
      Name = "pvt-8b"
    }
  
}

# Creating Internet Gateway
resource "aws_internet_gateway" "three-tier-ig" {
    vpc_id = aws_vpc.three-tier.id
    tags = {
      Name = "3-tier-igw"
    }
  
}

# Creating public Route table
resource "aws_route_table" "three-tier-pub-rt" {
    vpc_id = aws_vpc.three-tier.id
    tags = {
      Name = "3-tier-pub-rt"
    }
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.three-tier-ig.id
    }
  
}
# Attaching pub-1a subnet to public route table
resource "aws_route_table_association" "public-1a" {
    route_table_id = aws_route_table.three-tier-pub-rt.id
    subnet_id = aws_subnet.public-subnet-1.id
  
}
# Attaching pub-2b subnet to public route table
resource "aws_route_table_association" "public-2b" {
    route_table_id = aws_route_table.three-tier-pub-rt.id
    subnet_id = aws_subnet.public-subnet-2.id
}
# Creating elastic ip for nat gateway
resource "aws_eip" "eip" {
    domain = "vpc"
    
}
# Creating NAT Gateway
resource "aws_nat_gateway" "custom-nat-gateway" {
    subnet_id = aws_subnet.public-subnet-1.id
    connectivity_type = "public"
    allocation_id = aws_eip.eip.id
    tags = {
      Name = "3-tier-nat"
    }
}
# Creating private route table
resource "aws_route_table" "three-tier-pvt-rt" {
    vpc_id = aws_vpc.three-tier.id
    tags = {
      Name = "3-tier-privt-rt"
    }
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.custom-nat-gateway.id
    }
  
}
# Attaching prvt-3a subnet to private route table
resource "aws_route_table_association" "private-3a" {
    route_table_id = aws_route_table.three-tier-pvt-rt.id
    subnet_id = aws_subnet.private-subnet-3.id
}
# Attaching prvt-4a subnet to private route table
resource "aws_route_table_association" "private-4b" {
    route_table_id = aws_route_table.three-tier-pvt-rt.id
    subnet_id = aws_subnet.private-subnet-4.id
}
# Attaching prvt-5a subnet to private route table
resource "aws_route_table_association" "private-5a" {
    route_table_id = aws_route_table.three-tier-pvt-rt.id
    subnet_id = aws_subnet.private-subnet-5.id
}
# Attaching prvt-6a subnet to private route table
resource "aws_route_table_association" "private-6b" {
    route_table_id = aws_route_table.three-tier-pvt-rt.id
    subnet_id = aws_subnet.private-subnet-6.id
}
# Attaching prvt-7a subnet to private route table
resource "aws_route_table_association" "private-7a" {
    route_table_id = aws_route_table.three-tier-pvt-rt.id
    subnet_id = aws_subnet.private-subnet-7.id
}
# Attaching prvt-8a subnet to private route table
resource "aws_route_table_association" "private-8b" {
    route_table_id = aws_route_table.three-tier-pvt-rt.id
    subnet_id = aws_subnet.private-subnet-8.id
}
