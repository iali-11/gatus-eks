resource "aws_iam_role" "eks_cluster_role" {
  name = "${var.cluster-name}-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = { Service = "eks.amazonaws.com" }
      }]
  })

  tags = {
    project-name = var.project-name
    cluster-name = var.cluster-name
  }
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy_attachment" {
  role       = aws_iam_role.eks_cluster_role.name
  policy_arn = var.cluster_policy_arn
}


resource "aws_iam_role" "node_role" {
  name = "${var.cluster-name}-node-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = { Service = "ec2.amazonaws.com" }
      }]
  })

  tags = {
    project-name = var.project-name
    cluster-name = var.cluster-name
  }
}

resource "aws_iam_role_policy_attachment" "eks_node_policy_attachment" {
  for_each = var.policy_attachments
  role     = aws_iam_role.node_role.name
  policy_arn = each.value.policy_arn
}