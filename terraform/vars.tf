#PROVIDER VARIABLES

variable "AWS_REGION" {
 type = "string"
}

variable "AWS_SECRET_KEY" {
 type = "string"
}

variable "AWS_ACCESS_KEY" {
 type = "string"
}

# ------------------------------------------------------------------------------
#VPC AND SUBNET VARIABLES
# ------------------------------------------------------------------------------

variable "vpc_cidr" {
  type        = "string"
  description = "Set the cidr block for VPC"
  default     = "10.8.0.0/16"
}

variable "Private_subnet_cidr" {
  type        = "string"
  description = "Set the cidr block for Private Subnet"
  default     = "10.8.0.0/24"
}

# ------------------------------------------------------------------------------
# EC2 INSTANCE CONFIGURATION (MASTER)
# ------------------------------------------------------------------------------

variable "ami_id" {
  description = "AMI ID"
  default     = "ami-0030ca8215a0bacdd"
}

variable "ec2_instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

#SECURITY KEYPAIR

variable "key_pair_sec" {
  type = "string"
}
