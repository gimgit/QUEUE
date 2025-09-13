# VPC
resource "aws_vpc" "emr_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.project_name}-vpc"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "emr_igw" {
  vpc_id = aws_vpc.emr_vpc.id

  tags = {
    Name = "${var.project_name}-igw"
  }
}

# Subnets
resource "aws_subnet" "emr_public_subnet" {
  vpc_id                  = aws_vpc.emr_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-public-subnet"
  }
}

resource "aws_subnet" "emr_private_subnet" {
  vpc_id            = aws_vpc.emr_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "${var.project_name}-private-subnet"
  }
}

# NAT Gateway
resource "aws_eip" "emr_nat_eip" {
  domain = "vpc"
  tags = {
    Name = "${var.project_name}-nat-eip"
  }
}

resource "aws_nat_gateway" "emr_nat_gw" {
  allocation_id = aws_eip.emr_nat_eip.id
  subnet_id     = aws_subnet.emr_public_subnet.id

  tags = {
    Name = "${var.project_name}-nat-gw"
  }

  depends_on = [aws_internet_gateway.emr_igw]
}

# Route Tables
resource "aws_route_table" "emr_public_rt" {
  vpc_id = aws_vpc.emr_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.emr_igw.id
  }

  tags = {
    Name = "${var.project_name}-public-rt"
  }
}

resource "aws_route_table" "emr_private_rt" {
  vpc_id = aws_vpc.emr_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.emr_nat_gw.id
  }

  tags = {
    Name = "${var.project_name}-private-rt"
  }
}

# Route Table Associations
resource "aws_route_table_association" "emr_public_rta" {
  subnet_id      = aws_subnet.emr_public_subnet.id
  route_table_id = aws_route_table.emr_public_rt.id
}

resource "aws_route_table_association" "emr_private_rta" {
  subnet_id      = aws_subnet.emr_private_subnet.id
  route_table_id = aws_route_table.emr_private_rt.id
}

# Security Groups
resource "aws_security_group" "emr_master_sg" {
  name        = "${var.project_name}-emr-master-sg"
  description = "Security group for EMR master node"
  vpc_id      = aws_vpc.emr_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 0
    to_port   = 65535
    protocol  = "tcp"
    self      = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-emr-master-sg"
  }
}

resource "aws_security_group" "emr_worker_sg" {
  name        = "${var.project_name}-emr-worker-sg"
  description = "Security group for EMR worker nodes"
  vpc_id      = aws_vpc.emr_vpc.id

  ingress {
    from_port       = 0
    to_port         = 65535
    protocol        = "tcp"
    security_groups = [aws_security_group.emr_master_sg.id]
  }

  ingress {
    from_port = 0
    to_port   = 65535
    protocol  = "tcp"
    self      = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-emr-worker-sg"
  }
}
