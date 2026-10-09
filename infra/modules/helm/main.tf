resource "helm_release" "nginx" {
  name       = "nginx-ingress"
  repository = "https://helm.nginx.com/stable"
  chart      = "nginx-ingress"

  create_namespace = true
  namespace        = "nginx-ingress"

  values = [
    file("${path.module}/values/nginx.yaml")
  ]

  depends_on = [
    var.eks_access_policy_association_arn
  ]
}

resource "helm_release" "cert_manager" {
  name       = "cert-manager"
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"

  create_namespace = true
  namespace        = "cert-manager"

  values = [
    file("${path.module}/values/cert-manager.yaml")
  ]

  depends_on = [
    var.cert_manager_role_arn,
    var.eks_access_policy_association_arn
  ]
}

resource "helm_release" "external_dns" {
  name       = "external-dns"
  repository = "https://kubernetes-sigs.github.io/external-dns/"
  chart      = "external-dns"

  create_namespace = true
  namespace        = "external-dns"

  values = [
    file("${path.module}/values/external-dns.yaml")
  ]

  depends_on = [
    var.external_dns_role_arn,
    var.eks_access_policy_association_arn
  ]
}

resource "helm_release" "argo_cd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  timeout    = 600

  create_namespace = true
  namespace        = "argo-cd"

  values = [
    file("${path.module}/values/argocd.yaml")
  ]

  depends_on = [
    var.eks_access_policy_association_arn
  ]
}