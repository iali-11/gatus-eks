resource "aws_iam_role" "eks_cluster_role" {
  name = "${var.cluster-name}-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Sid       = ""
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
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Sid       = ""
      Principal = { Service = "ec2.amazonaws.com" }
    }]
  })

  tags = {
    project-name = var.project-name
    cluster-name = var.cluster-name
  }
}

resource "aws_iam_role_policy_attachment" "eks_node_policy_attachment" {
  for_each = toset([
    var.eks_worker_node_policy_arn,
    var.ecr_registry_policy_arn,
    var.cni_policy_arn
  ])
  role       = aws_iam_role.node_role.name
  policy_arn = each.value
}

resource "aws_iam_role" "ebs_csi" {
  name = var.ebs_csi_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole",
          "sts:TagSession"
        ]
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "pods.eks.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    project-name = var.project-name
    cluster-name = var.cluster-name
  }
}

resource "aws_iam_role_policy_attachment" "ebs_csi_policy_attachment" {
  role       = aws_iam_role.ebs_csi.name
  policy_arn = var.ebs_csi_policy_arn
}

resource "aws_iam_role" "cert_manager" {
  name = var.cert_manager_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "sts:AssumeRole",
        "sts:TagSession"
      ]
      Effect    = "Allow"
      Sid       = ""
      Principal = { Service = "pods.eks.amazonaws.com" }
    }]
  })

  tags = {
    project-name = var.project-name
    cluster-name = var.cluster-name
  }
}

resource "aws_iam_policy" "cert_manager_route53" {
  name = var.cert_manager_policy_name

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : "route53:GetChange",
        "Resource" : "arn:aws:route53:::change/*"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "route53:ChangeResourceRecordSets"
        ],
        "Resource" : "arn:aws:route53:::hostedzone/${var.hostedzone_id}",
        "Condition" : {
          "ForAllValues:StringEquals" : {
            "route53:ChangeResourceRecordSetsRecordTypes" : ["TXT"]
          }
        }
      },
      {
        "Effect" : "Allow",
        "Action" : "route53:ListHostedZonesByName",
        "Resource" : "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "cert_manager_policy_attachment" {
  role       = aws_iam_role.cert_manager.name
  policy_arn = aws_iam_policy.cert_manager_route53.arn
}

resource "aws_iam_role" "external_dns" {
  name = var.external_dns_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "sts:AssumeRole",
        "sts:TagSession"
      ]
      Effect    = "Allow"
      Sid       = ""
      Principal = { Service = "pods.eks.amazonaws.com" }
    }]
  })

  tags = {
    project-name = var.project-name
    cluster-name = var.cluster-name
  }
}

resource "aws_iam_policy" "external_dns_01" {
  name = var.external_dns_policy_name

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "route53:ChangeResourceRecordSets",
          "route53:ListResourceRecordSets",
          "route53:ListTagsForResources"
        ],
        "Resource" : [
          "arn:aws:route53:::hostedzone/${var.hostedzone_id}"
        ]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "route53:ListHostedZones"
        ],
        "Resource" : [
          "*"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "external_dns_policy_attachment" {
  role       = aws_iam_role.external_dns.name
  policy_arn = aws_iam_policy.external_dns_01.arn
}