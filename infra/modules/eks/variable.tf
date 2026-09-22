variable "project-name" {
  type = string
}

variable "private_subnets_ids" {
  type = list(string)
}

variable "cluster-name" {
  type = string
}

variable "eks_cluster_role_arn" {
  type = string
}

variable "node_role_arn" {
  type = string
}

variable "kube-proxy" {
  type = string
}

variable "vpc-cni" {
  type = string
}

variable "coredns" {
  type = string
}

variable "ebs-csi" {
  type = string
}

variable "pod-identity-agent" {
  type = string
}

variable "auth_mode" {
  type = string
}

variable "kube_version" {
  type = string
}

variable "desired_size" {
  type = number
}

variable "max_size" {
  type = number
}

variable "min_size" {
  type = number
}

variable "max_unavailable" {
  type = number
}

variable "public_access_cidrs" {
  type = string
}

variable "cert_manager_role_arn" {
  type = string
}

variable "external_dns_role_arn" {
  type = string
}

variable "ebs_csi_role_arn" {
  type = string
}

variable "capacity_type" {
  type = string
}

variable "disk_size" {
  type = number
}

variable "disk_type" {
  type = string
}

variable "instance_types" {
  type = string
}

variable "eks_cluster_sg_id" {
  type = string
}

variable "node_sg_id" {
  type = string
}