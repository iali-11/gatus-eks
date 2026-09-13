variable "project-name" {
  type = string
}

variable "private_subnets_ids" {
  type = list(string)
}

variable "cluster-name" {
  type = string
}

variable "eks_cluster_policy_attachment_id" {
  type = string
}

variable "eks_cluster_role_arn" {
  type = string
}

variable "node_role_arn" {
  type = string
}

variable "node_policy_attachment_ids" {
  type = list(string)
}