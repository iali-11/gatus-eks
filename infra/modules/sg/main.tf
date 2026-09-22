# EKS Cluster Security Group

resource "aws_security_group" "eks_cluster_sg" {
  name   = "${var.cluster-name}-sg"
  vpc_id = var.vpc_id

  tags = {
    Name         = "${var.cluster-name}-sg"
    project-name = var.project-name
  }
}

# Allow EKS nodes to communicate with Kubernetes API over HTTPS
resource "aws_vpc_security_group_ingress_rule" "cluster_from_nodes" {
  security_group_id            = aws_security_group.eks_cluster_sg.id
  referenced_security_group_id = aws_security_group.eks_node_sg.id
  from_port                    = 443
  ip_protocol                  = "tcp"
  to_port                      = 443
}

# Allow all outbound traffic from cluster
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_cluster" {
  security_group_id = aws_security_group.eks_cluster_sg.id
  cidr_ipv4         = var.default_cidr_block
  ip_protocol       = "-1" # semantically equivalent to all ports
}

# EKS Node Security Group

resource "aws_security_group" "eks_node_sg" {
  name   = "${var.cluster-name}-node-sg"
  vpc_id = var.vpc_id

  tags = {
    Name         = "${var.cluster-name}-node-sg"
    project-name = var.project-name
  }
}

# Allow nodes to communicate with each other
resource "aws_vpc_security_group_ingress_rule" "node_self" {
  security_group_id            = aws_security_group.eks_node_sg.id
  referenced_security_group_id = aws_security_group.eks_node_sg.id
  ip_protocol                  = "-1"
}

# Allow EKS Cluster to interact with the nodes for Kubelet communication
resource "aws_vpc_security_group_ingress_rule" "cluster_to_nodes" {
  security_group_id            = aws_security_group.eks_node_sg.id
  referenced_security_group_id = aws_security_group.eks_cluster_sg.id
  from_port                    = 10250
  ip_protocol                  = "tcp"
  to_port                      = 10250
}

# Allow all outbound traffic from nodes
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_node" {
  security_group_id = aws_security_group.eks_node_sg.id
  cidr_ipv4         = var.default_cidr_block
  ip_protocol       = "-1" # semantically equivalent to all ports
}

# RDS Security Group

resource "aws_security_group" "rds_sg" {
  name   = "${var.project-name}-rds-sg"
  vpc_id = var.vpc_id

  tags = {
    Name         = "${var.project-name}-rds-sg"
    project-name = var.project-name
  }
}

# Allow EKS to access PostgreSQL
resource "aws_vpc_security_group_ingress_rule" "rds_from_nodes" {
  security_group_id            = aws_security_group.rds_sg.id
  referenced_security_group_id = aws_security_group.eks_node_sg.id
  from_port                    = 5432
  ip_protocol                  = "tcp"
  to_port                      = 5432
}

# Allow all outbound traffic from RDS
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_rds" {
  security_group_id = aws_security_group.rds_sg.id
  cidr_ipv4         = var.default_cidr_block
  ip_protocol       = "-1" # semantically equivalent to all ports
}