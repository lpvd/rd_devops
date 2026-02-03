variable "ami" {
  description = "AMI ID"
}

variable "instance_type" {
  description = "EC2 instance type"
}

variable "subnet_id" {
  description = "Subnet ID"
}

variable "public_ip" {
  description = "Attach public IP"
  type        = bool
}

variable "name" {
  description = "Instance name"
}
