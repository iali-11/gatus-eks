output "cluster_policy_arn" {
  value = var.cluster_policy_arn
}

output "eks_worker_node_policy_arn" {
  value = var.eks_worker_node_policy_arn
}

output "ecr_registry_policy_arn" {
  value = var.ecr_registry_policy_arn
}

output "cni_policy_arn" {
  value = var.cni_policy_arn
}

output "eks_cluster_role_arn" {
  value = aws_iam_role.eks_cluster_role.arn
}

output "eks_cluster_policy_attachment_id" {
  value = aws_iam_role_policy_attachment.eks_cluster_policy_attachment.id
}

output "node_role_arn" {
  value = aws_iam_role.node_role.arn
}

output "node_policy_attachment_ids" {
  value = [ for a in aws_iam_role_policy_attachment.eks_node_policy_attachment : a.id ]
}