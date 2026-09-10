module "vpc" {
  source                     = "./modules/vpc"
  project-name               = var.project-name
  default_cidr_block         = var.default_cidr_block
  vpc_cidr_block             = var.vpc_cidr_block
  public_subnet_cidr_blocks  = var.public_subnet_cidr_blocks
  private_subnet_cidr_blocks = var.private_subnet_cidr_blocks
  availability_zones         = var.availability_zones
}