#create eks cluster
resource "aws_eks_cluster" "eks-cluster" {
  name       = "eda-eks-cluster"
  role_arn   = aws_iam_role.eks-iam-role.arn
  depends_on = [aws_iam_role_policy_attachment.eks-iam-policy-attachment]
  vpc_config {
    subnet_ids              = [var.pvtcidrid, var.pubcidrid]
    security_group_ids      = [aws_security_group.eks-cluster.id, aws_security_group.eks-node.id]
    endpoint_private_access = false
    endpoint_public_access  = true
  }
  tags = merge(var.tags,
    {
      Name = "eda-eks-cluster"
    }
  )

}

# Create EKS node group
resource "aws_eks_node_group" "eks-node-group" {
  cluster_name    = aws_eks_cluster.eks-cluster.name
  node_group_name = "eda-eks-node-group"
  node_role_arn   = aws_iam_role.eda-nodes-iam-role.arn
  subnet_ids      = [var.pvtcidrid]
  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 2
  }
  depends_on = [aws_iam_role_policy_attachment.eks-iam-policy-attachment]
  tags = merge(var.tags,
    {
      Name = "eda-eks-node-group"
    }
  )
}