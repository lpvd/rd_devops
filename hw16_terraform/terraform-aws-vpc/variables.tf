variable "region" {
  description = "AWS region where resources will be created"
  default     = "eu-central-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR block for the private subnet"
  default     = "10.0.2.0/24"
}

variable "availability_zone" {
  description = "Availability Zone for subnets"
  default     = "eu-central-1a"
}

variable "ami_id" {
  description = "AMI ID for EC2 instances, will be provided later"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}
