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

resource "null_resource" "create_alb" {
  provisioner "local-exec" {
    command = "kubectl apply -n argocd -f ${path.module}/alb.yaml"
    interpreter = ["bash", "-c"]
  }
}
resource "null_resource" "get_argocd_password" {
  depends_on = [ null_resource.apply_argocd ]
  provisioner "local-exec" {
    command = "kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d"
    interpreter = ["bash", "-c"]
  }
#  provisioner "local-exec" {
#    command = "kubectl port-forward svc/argocd-server -n argocd 8080:443 &"
#    interpreter = ["bash", "-c"]
#  }
}

