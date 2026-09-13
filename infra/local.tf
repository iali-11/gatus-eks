locals {
  project-name = "gatus-eks"
  cluster-name = "gatus-eks-cluster"

  attachment = {
    worker_node_policy = {
      policy_arn = var.eks_worker_node_policy_arn
    }
    ecr_node_readonly = {
      policy_arn = var.ecr_registry_policy_arn
    }
    eks_cni_policy = {
      policy_arn = var.cni_policy_arn
    }
  }

}