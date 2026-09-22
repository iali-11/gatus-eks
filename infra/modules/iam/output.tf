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

output "node_role_arn" {
  value = aws_iam_role.node_role.arn
}

output "cert_manager_role_arn" {
  value = aws_iam_role.cert_manager.arn
}

output "external_dns_role_arn" {
  value = aws_iam_role.external_dns.arn
}

output "ebs_csi_role_arn" {
  value = aws_iam_role.ebs_csi.arn
}