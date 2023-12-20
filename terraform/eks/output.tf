output "cluster_endpoint" {
  value = aws_eks_cluster.eks-cluster.endpoint
}
output "cluster_certificate_authority_data" {
  value = aws_eks_cluster.eks-cluster.certificate_authority[0].data
}
output "cluster_name" {
  value = aws_eks_cluster.eks-cluster.name
}
data "aws_eks_cluster_auth" "eks_token" {
  name = aws_eks_cluster.eks-cluster.name
}

output "eks_token" {
  value = data.aws_eks_cluster_auth.eks_token.token
}