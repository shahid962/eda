#EKS cluster security group
resource "aws_security_group" "eks-cluster" {
  name        = "eks-sg"
  description = "EKS security group"
  vpc_id      = var.vpcid
  tags = merge(var.tags,
    {
      Name = "Shahid-eks-cluster-sg"
    }
  )
} #EKS cluster node security group
resource "aws_security_group" "eks-node" {
  name        = "eks-node-sg"
  description = "EKS node security group"
  vpc_id      = var.vpcid
  tags = merge(var.tags,
    {
      Name = "Shahid-eks-node-sg"
    }
  )
}
##############
#EKS cluster security group rules starts
resource "aws_security_group_rule" "cluster_inbound" {
  description              = "allow worker nodes to communicate with the cluster API Server"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.eks-cluster.id
  source_security_group_id = aws_security_group.eks-node.id
  type                     = "ingress"
}

resource "aws_security_group_rule" "cluster_outbound" {
  description              = "allow worker nodes to communicate with other worker nodes and the cluster control plane"
  from_port                = 1024
  to_port                  = 65535
  protocol                 = "tcp"
  security_group_id        = aws_security_group.eks-cluster.id
  source_security_group_id = aws_security_group.eks-node.id
  type                     = "egress"
}

###Cluster security group rules ends

#EKS cluster node security group rules starts
resource "aws_security_group_rule" "node_inbound" {
  description              = "allow worker nodes to communicate with the other worker node and cluster API Server"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.eks-node.id
  source_security_group_id = aws_security_group.eks-cluster.id
  type                     = "ingress"
}

resource "aws_security_group_rule" "node_outbound" {
  description              = "allow worker nodes to communicate with the internet"
  from_port                = 1024
  to_port                  = 65535
  protocol                 = "tcp"
  security_group_id        = aws_security_group.eks-node.id
  source_security_group_id = aws_security_group.eks-cluster.id
  type                     = "egress"
}