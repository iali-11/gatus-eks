resource "aws_eks_cluster" "eks_cluster" {
  name = var.cluster-name

  access_config {
    authentication_mode = "API"
    bootstrap_cluster_creator_admin_permissions = true
  }

  role_arn = var.eks_cluster_role_arn
  version  = "1.36"

  vpc_config {
    subnet_ids = var.private_subnets_ids
    endpoint_private_access = true
    endpoint_public_access = true
  }

  depends_on = [ var.eks_cluster_policy_attachment_id ]

  tags = {
    cluster = var.cluster-name
  }
}

resource "aws_eks_node_group" "node_group" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "${var.cluster-name}-node-group"
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.private_subnets_ids

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  depends_on = [
    var.node_policy_attachment_ids
  ]
}