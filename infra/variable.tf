variable "project-name" {
  type    = string
  default = "gatus-eks"
}

# VPC values

variable "vpc_cidr_block" {
  default = "10.0.0.0/20"
  type    = string
}

variable "public_subnet_cidr_blocks" {
  default = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
  type    = list(string)
}

variable "private_subnet_cidr_blocks" {
  default = ["10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24"]
  type    = list(string)
}

variable "availability_zones" {
  default = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
  type    = list(string)
}

variable "default_cidr_block" {
  default = "0.0.0.0/0"
  type    = string
}

# iam values

variable "cluster_policy_arn" {
  type    = string
  default = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

variable "eks_worker_node_policy_arn" {
  type    = string
  default = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

variable "ecr_registry_policy_arn" {
  type    = string
  default = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPullOnly"
}

variable "cni_policy_arn" {
  type    = string
  default = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

variable "hostedzone_id" {
  type    = string
  default = "Z02139843GGR93Z9N2VGJ"
}

variable "cert_manager_role_name" {
  type    = string
  default = "cert-manager-role"
}

variable "cert_manager_policy_name" {
  type    = string
  default = "cert-manager-policy"
}

variable "external_dns_role_name" {
  type    = string
  default = "external-dns-role"
}

variable "external_dns_policy_name" {
  type    = string
  default = "external-dns-policy"
}

variable "ebs_csi_policy_arn" {
  type    = string
  default = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
}

variable "ebs_csi_role_name" {
  type    = string
  default = "ebs_csi_role"
}

# EKS Values

variable "cluster-name" {
  type    = string
  default = "gatus-eks-cluster"
}

variable "auth_mode" {
  type    = string
  default = "API"
}

variable "kube_version" {
  type    = string
  default = "1.36"
}

variable "desired_size" {
  type    = number
  default = 3
}

variable "max_size" {
  type    = number
  default = 4
}

variable "min_size" {
  type    = number
  default = 3
}

variable "max_unavailable" {
  type    = number
  default = 1
}

variable "kube-proxy" {
  type    = string
  default = "kube-proxy"
}

variable "vpc-cni" {
  type    = string
  default = "vpc-cni"
}

variable "coredns" {
  type    = string
  default = "coredns"
}

variable "ebs-csi" {
  type    = string
  default = "aws-ebs-csi-driver"
}

variable "pod-identity-agent" {
  type    = string
  default = "eks-pod-identity-agent"
}

variable "public_access_cidrs" {
  type    = string
  default = "0.0.0.0/0"
}

variable "capacity_type" {
  type    = string
  default = "ON_DEMAND"
}

variable "disk_size" {
  type    = number
  default = 30
}

variable "disk_type" {
  type    = string
  default = "gp3"
}

variable "instance_types" {
  type    = string
  default = "t3.medium"
}

# RDS Values

variable "db_name" {
  type    = string
  default = "gatus"
}

variable "db_engine" {
  type    = string
  default = "postgres"
}

variable "instance_class" {
  type    = string
  default = "db.t3.micro"
}

variable "allocated_storage" {
  type    = number
  default = 20
}

variable "db_username" {
  description = "RDS database username"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "RDS database password"
  type        = string
  sensitive   = true
}