module "vpc" {
  source                     = "./modules/vpc"
  project-name               = local.project-name
  default_cidr_block         = var.default_cidr_block
  vpc_cidr_block             = var.vpc_cidr_block
  public_subnet_cidr_blocks  = var.public_subnet_cidr_blocks
  private_subnet_cidr_blocks = var.private_subnet_cidr_blocks
  availability_zones         = var.availability_zones
  cluster-name               = local.cluster-name
}

module "eks" {
  source                           = "./modules/eks"
  project-name                     = local.project-name
  private_subnets_ids              = module.vpc.private_subnets_ids
  cluster-name                     = local.cluster-name
  eks_cluster_role_arn             = module.iam.eks_cluster_role_arn
  eks_cluster_policy_attachment_id = module.iam.eks_cluster_policy_attachment_id
  node_role_arn                    = module.iam.node_role_arn
  node_policy_attachment_ids       = module.iam.node_policy_attachment_ids
}

module "iam" {
  source                     = "./modules/iam"
  cluster-name               = local.cluster-name
  project-name               = local.project-name
  cluster_policy_arn         = var.cluster_policy_arn
  eks_worker_node_policy_arn = var.eks_worker_node_policy_arn
  ecr_registry_policy_arn    = var.ecr_registry_policy_arn
  cni_policy_arn             = var.cni_policy_arn
  policy_attachments         = local.attachment
}