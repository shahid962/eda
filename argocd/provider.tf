terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      #version = "2.5.0"
    }
  }
}

# provider "kubernetes" {
#   config_path = "~/.kube/config"
#   config_context = "xxxxx"
#   alias = "eks"
# }

provider "kubernetes" {
  host = var.eks_cluster_endpoint
  cluster_ca_certificate = base64decode(var.eks_cluster_ca_certificate)
  token = var.eks_token
  alias = "eks"
  
}