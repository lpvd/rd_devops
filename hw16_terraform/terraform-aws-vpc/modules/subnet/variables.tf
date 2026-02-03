variable "vpc_id" {
  description = "VPC ID"
}

variable "cidr_block" {
  description = "Subnet CIDR"
}

variable "az" {
  description = "Availability Zone"
}

variable "public" {
  description = "Whether the subnet is public"
  type        = bool
}

variable "name" {
  description = "Subnet name"
}
