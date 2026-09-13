# VPC values

variable "vpc_cidr_block" {
  default = "10.0.0.0/20"
  type    = string
}

variable "public_subnet_cidr_blocks" {
  default = ["10.0.1.0/24", "10.0.2.0/24"]
  type    = list(string)
}

variable "private_subnet_cidr_blocks" {
  default = ["10.0.3.0/24", "10.0.4.0/24"]
  type    = list(string)
}

variable "availability_zones" {
  default = ["eu-west-2a", "eu-west-2b"]
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