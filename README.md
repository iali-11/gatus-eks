# Gatus on EKS - Production-Grade Uptime Monitoring on AWS

![AWS](https://img.shields.io/badge/AWS-EKS%20%7C%20EFS%20%7C%20Route%2053-FF9900?style=for-the-badge&logo=amazonaws&logoColor=white)
![Terraform](https://img.shields.io/badge/Terraform-Infrastructure%20as%20Code-623CE4?style=for-the-badge&logo=terraform&logoColor=white)
![Kubernetes](https://img.shields.io/badge/Kubernetes-EKS-326CE5?style=for-the-badge&logo=kubernetes&logoColor=white)
![Helm](https://img.shields.io/badge/Helm-Charts-0F1689?style=for-the-badge&logo=helm&logoColor=white)
![Argo CD](https://img.shields.io/badge/GitOps-ArgoCD-EF7B4D?style=for-the-badge&logo=argo&logoColor=white)
![GitHub Actions](https://img.shields.io/badge/CI%2FCD-GitHub%20Actions-2088FF?style=for-the-badge&logo=githubactions&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-Multi--Stage-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![NGINX](https://img.shields.io/badge/NGINX-Ingress_Controller-009639?style=for-the-badge&logo=nginx&logoColor=white)
![ExternalDNS](https://img.shields.io/badge/ExternalDNS-Automatic_DNS-4285F4?style=for-the-badge)
![Cert Manager](https://img.shields.io/badge/Cert_Manager-Let's_Encrypt-326CE5?style=for-the-badge)
![Prometheus](https://img.shields.io/badge/Prometheus-Grafana-E6522C?style=for-the-badge&logo=prometheus&logoColor=white)
![Security](https://img.shields.io/badge/Security-Trivy%20%7C%20Checkov%20%7C%20OIDC-0969DA?style=for-the-badge)

![Architecture Diagram](images/eks-architecture-diagram.png)

## Overview



## Application URL

➡️ https://app.gatus.ibrahimali.co.uk

![Live App](images/gatus-app.png)

## Repository Structure

```
.
├── .github/
│   └── workflows/
│       ├── docker-build-push.yaml
│       ├── deploy.yaml
│       └── destroy.yml
│
├── app/
│   ├── Dockerfile
│   └── config.yaml
│
├── bootstrap/
│   ├── ecr.tf
│   ├── main.tf
│   ├── output.tf
│   └── provider.tf
│
├── infra/
│   ├── main.tf
│   ├── provider.tf
│   ├── variables.tf
│   └── modules/
│       ├── vpc/
│       ├── eks/
│       ├── efs/
│       └── helm/
│           └── values/
│               ├── argo-cd.yaml
│               ├── cert-manager.yaml
│               ├── external-dns.yaml
│               ├── kube-prometheus-stack.yaml
│               └── nginx-ingress.yaml
│
├── argocd/
│   └── applications/
│       └── gatus.yaml
│
├── charts/
│   └── gatus/
│
├── .gitignore
└── README.md