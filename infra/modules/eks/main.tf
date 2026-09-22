resource "aws_eks_cluster" "eks_cluster" {
  name = var.cluster-name

  access_config {
    authentication_mode                         = var.auth_mode
    bootstrap_cluster_creator_admin_permissions = true
  }

  role_arn = var.eks_cluster_role_arn
  version  = var.kube_version

  vpc_config {
    subnet_ids              = var.private_subnets_ids
    security_group_ids      = [var.eks_cluster_sg_id]
    endpoint_private_access = true
    endpoint_public_access  = true
    public_access_cidrs     = [var.public_access_cidrs]
  }

  tags = {
    cluster = var.cluster-name
  }
}

resource "aws_launch_template" "nodes" {
  name = "${var.cluster-name}-node-lt"

  vpc_security_group_ids = [var.node_sg_id]
  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size = var.disk_size
      volume_type = var.disk_type
    }
  }
}

resource "aws_eks_node_group" "node_group" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "${var.cluster-name}-node-group"
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.private_subnets_ids
  capacity_type   = var.capacity_type
  instance_types  = [var.instance_types]

  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }

  update_config {
    max_unavailable = var.max_unavailable
  }

  launch_template {
    id      = aws_launch_template.nodes.id
    version = aws_launch_template.nodes.latest_version
  }
}

resource "aws_eks_addon" "eks_addon_before_compute" {
  for_each = toset([
    var.kube-proxy,
    var.vpc-cni
  ])
  cluster_name = aws_eks_cluster.eks_cluster.name
  addon_name   = each.value
}

resource "aws_eks_addon" "eks_addon_after_compute" {
  for_each = toset([
    var.pod-identity-agent,
    var.coredns,
    var.ebs-csi
  ])
  cluster_name = aws_eks_cluster.eks_cluster.name
  addon_name   = each.value
  depends_on   = [aws_eks_node_group.node_group]
}

resource "aws_eks_pod_identity_association" "cert_manager" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  namespace       = "cert-manager"
  service_account = "cert-manager"
  role_arn        = var.cert_manager_role_arn
}

resource "aws_eks_pod_identity_association" "external_dns" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  namespace       = "external-dns"
  service_account = "external-dns"
  role_arn        = var.external_dns_role_arn
}

resource "aws_eks_pod_identity_association" "ebs_csi" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  namespace       = "kube-system"
  service_account = "ebs-csi-controller-sa"
  role_arn        = var.ebs_csi_role_arn
}