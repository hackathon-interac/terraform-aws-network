provider "aws" {
  region = "${var.region}"
}

locals {
  vpc_name = "${var.project_name}-${var.env}-vpc"
  subnet_name = "${var.project_name}-${var.env}-subnet"
}

data "aws_availability_zones" "available" {}

resource "aws_vpc" "main" {
  cidr_block           = "${var.cidr_block}"
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

 tags = {
          Name = "${local.vpc_name}"
  }
 
}

resource "aws_subnet" "public" {
  vpc_id = "${aws_vpc.main.id}"

  cidr_block              = cidrsubnet(var.cidr_block, 4, 0 )
  map_public_ip_on_launch = true


 tags = {
          Name = "${local.subnet_name}-public"
  }
}


resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.main.id}"

 tags = {
          Name = "${var.project_name}-${var.env}-rt"
  }
}

resource "aws_route_table_association" "public" {

  subnet_id      = "${aws_subnet.public.id}"
  route_table_id = "${aws_route_table.public.id}"
}

resource "aws_internet_gateway" "main" {
  vpc_id = "${aws_vpc.main.id}"

 tags = {
          Name = "${var.project_name}-${var.env}-ig"
  }

}
resource "aws_route" "public_internet_gateway" {
  route_table_id         = "${aws_route_table.public.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.main.id}"

  timeouts {
    create = "5m"
  }
}


# Private Subnets, Routes & NAT 

resource "aws_subnet" "private" {
  count = var.env == "prod" ? 2 : 1

  vpc_id = "${aws_vpc.main.id}"

  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
  cidr_block        =  cidrsubnet(var.cidr_block, 4, count.index )


 tags = {
          Name = "${local.subnet_name}-private"
  }
}
