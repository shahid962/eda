################################################################################
# EKS Addons
################################################################################

resource "aws_eks_addon" "ebs_csi_driver" {
  cluster_name                = aws_eks_cluster.eks-cluster.name
  addon_name                  = "aws-ebs-csi-driver"
  #addon_version               = var.eks_addon_version
  resolve_conflicts_on_create = "OVERWRITE"
  service_account_role_arn    = aws_iam_role.eks_addon_ebs.arn
  depends_on                  = [aws_iam_role.eks_addon_ebs]
}

################################################################################
# IRSA(IAM Roles for Service Account)
################################################################################

data "tls_certificate" "tls" {
  url = aws_eks_cluster.eks-cluster.identity[0].oidc[0].issuer
  #url = aws_eks_cluster.eks-cluster.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "oidc_provider" {
  client_id_list  = [ "sts.amazonaws.com" ]
  thumbprint_list = [data.tls_certificate.tls.certificates[0].sha1_fingerprint]
  url = data.tls_certificate.tls.url
}


#########Policy for EKS Addon
data "aws_iam_policy" "ebs_csi_driver" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
}


data "aws_iam_policy_document" "ebs_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.oidc_provider.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:ebs-csi-controller-sa"]
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.oidc_provider.arn]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "eks_addon_ebs" {
  assume_role_policy = data.aws_iam_policy_document.ebs_assume_role_policy.json
  name               = "aws-ebs-csi-driver-role"
  path               = "/"

}