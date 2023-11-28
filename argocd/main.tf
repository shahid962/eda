#creating namespace
resource "kubernetes_namespace" "argocd" {
    provider = kubernetes.eks
  metadata {
    name = "argocd"
  }
  
}


resource "null_resource" "apply_argocd" {
  provisioner "local-exec" {
    command = "kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml"
    interpreter = ["bash", "-c"]
  }
}
