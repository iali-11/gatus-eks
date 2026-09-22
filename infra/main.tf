module "vpc" {
  source                     = "./modules/vpc"
  project-name               = var.project-name
  default_cidr_block         = var.default_cidr_block
  vpc_cidr_block             = var.vpc_cidr_block
  public_subnet_cidr_blocks  = var.public_subnet_cidr_blocks
  private_subnet_cidr_blocks = var.private_subnet_cidr_blocks
  availability_zones         = var.availability_zones
  cluster-name               = var.cluster-name
}

module "eks" {
  source                = "./modules/eks"
  project-name          = var.project-name
  private_subnets_ids   = module.vpc.private_subnets_ids
  cluster-name          = var.cluster-name
  eks_cluster_role_arn  = module.iam.eks_cluster_role_arn
  node_role_arn         = module.iam.node_role_arn
  kube-proxy            = var.kube-proxy
  vpc-cni               = var.vpc-cni
  coredns               = var.coredns
  ebs-csi               = var.ebs-csi
  pod-identity-agent    = var.pod-identity-agent
  auth_mode             = var.auth_mode
  kube_version          = var.kube_version
  desired_size          = var.desired_size
  max_size              = var.max_size
  min_size              = var.min_size
  max_unavailable       = var.max_unavailable
  public_access_cidrs   = var.public_access_cidrs
  depends_on            = [module.iam]
  cert_manager_role_arn = module.iam.cert_manager_role_arn
  external_dns_role_arn = module.iam.external_dns_role_arn
  ebs_csi_role_arn      = module.iam.ebs_csi_role_arn
  capacity_type         = var.capacity_type
  disk_size             = var.disk_size
  disk_type             = var.disk_type
  instance_types        = var.instance_types
  eks_cluster_sg_id     = module.sg.eks_cluster_sg_id
  node_sg_id            = module.sg.node_sg_id
}

module "iam" {
  source                     = "./modules/iam"
  cluster-name               = var.cluster-name
  project-name               = var.cluster-name
  cluster_policy_arn         = var.cluster_policy_arn
  eks_worker_node_policy_arn = var.eks_worker_node_policy_arn
  ecr_registry_policy_arn    = var.ecr_registry_policy_arn
  cni_policy_arn             = var.cni_policy_arn
  hostedzone_id              = var.hostedzone_id
  cert_manager_role_name     = var.cert_manager_role_name
  cert_manager_policy_name   = var.cert_manager_policy_name
  external_dns_role_name     = var.external_dns_role_name
  external_dns_policy_name   = var.external_dns_policy_name
  ebs_csi_policy_arn         = var.ebs_csi_policy_arn
  ebs_csi_role_name          = var.ebs_csi_role_name
}

module "sg" {
  source             = "./modules/sg"
  cluster-name       = var.cluster-name
  vpc_id             = module.vpc.vpc_id
  default_cidr_block = var.default_cidr_block
  project-name       = var.project-name
}

module "rds" {
  source              = "./modules/rds"
  project-name        = var.project-name
  cluster-name        = var.cluster-name
  private_subnets_ids = module.vpc.private_subnets_ids
  rds_sg_id           = module.sg.rds_sg_id
  db_name             = var.db_name
  db_engine           = var.db_engine
  allocated_storage   = var.allocated_storage
  instance_class      = var.instance_class
  db_password         = var.db_password
  db_username         = var.db_username
}