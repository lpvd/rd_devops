module "vpc" {
  source     = "./modules/vpc"
  cidr_block = var.vpc_cidr
  name       = "demo-vpc"
}

module "public_subnet" {
  source      = "./modules/subnet"
  vpc_id      = module.vpc.vpc_id
  cidr_block  = var.public_subnet_cidr
  az          = var.availability_zone
  public      = true
  name        = "public-subnet"
}

module "private_subnet" {
  source      = "./modules/subnet"
  vpc_id      = module.vpc.vpc_id
  cidr_block  = var.private_subnet_cidr
  az          = var.availability_zone
  public      = false
  name        = "private-subnet"
}

module "public_ec2" {
  source        = "./modules/ec2"
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = module.public_subnet.subnet_id
  public_ip     = true
  name          = "public-ec2"
}

module "private_ec2" {
  source        = "./modules/ec2"
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = module.private_subnet.subnet_id
  public_ip     = false
  name          = "private-ec2"
}

