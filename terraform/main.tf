# NETWORK
# ------------------------------------------------------------------------------
# CREATE THE VPC WITH INTERNET ACCESS
# ------------------------------------------------------------------------------

resource "aws_vpc" "Tona_VPC" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name        = "Tona_VPC"
    Environment = "DEV"
  }
}

# ------------------------------------------------------------------------------
# CREATE A NEW PRIVATE SUBNET
# ------------------------------------------------------------------------------

resource "aws_subnet" "Tona_Private_Subnet" {
  vpc_id                  = "${aws_vpc.Tona_VPC.id}"
  cidr_block              = "${var.Private_subnet_cidr}"
  map_public_ip_on_launch = true
  tags = {
    Name        = "Tona Private Subnet"
    Environment = "nonprod"
  }
}
# INTERNET GATEWAY FOR Tona

resource "aws_internet_gateway" "Tona_Gateway" {
  vpc_id = "${aws_vpc.Tona_VPC.id}"
  tags = {
    Name        = "Tona Gateway"
    Environment = "DEV"
  }
}

# Grant the VPC internet access on its main route table
resource "aws_route" "Tona_route_internet" {
  route_table_id         = "${aws_vpc.Tona_VPC.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.Tona_Gateway.id}"


# ------------------------------------------------------------------------------
# CREATE SECURITY GROUP FOR INSTANCES
# ------------------------------------------------------------------------------

resource "aws_security_group" "Tona_Security_Group" {
  name        = "Tona-SG"
  description = "Tona Security Group"
  vpc_id      = "${aws_vpc.Tona_VPC.id}"

  # HTTP access from anywhere
  ingress {
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
    cidr_blocks = "0.0.0.0/0"
  }

# SSH access from anywhere
ingress {
  from_port   = "22"
  to_port     = "22"
  protocol    = "tcp"
  cidr_blocks = "0.0.0.0/0"
}

#CREATE AND EC2 INSTANCE
ami        = "${var.ami_id}"
instance_type   = "${var.ec2_instance_type}"
subnet_id       = "${aws_subnet.Tona_Private_Subnet.id}"
vpc_security_group_ids = ["${aws_security_group.Tona_Security_Group.id}"]
key_name        = "${var.key_pair_sec}"
