variable "project-name" {
  type = string
}

variable "cluster-name" {
  type = string
}

variable "cluster_policy_arn" {
  type = string
}

variable "eks_worker_node_policy_arn" {
  type = string
}

variable "ecr_registry_policy_arn" {
  type = string
}

variable "cni_policy_arn" {
  type = string
}

variable "hostedzone_id" {
  type = string
}

variable "cert_manager_role_name" {
  type = string
}

variable "cert_manager_policy_name" {
  type = string
}

variable "external_dns_role_name" {
  type = string
}

variable "external_dns_policy_name" {
  type = string
}

variable "ebs_csi_policy_arn" {
  type = string
}

variable "ebs_csi_role_name" {
  type = string
}