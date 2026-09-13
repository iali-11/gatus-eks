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

variable "policy_attachments" {
  type = map(object({
    policy_arn = string
  }))
}