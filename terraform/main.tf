
#Creating new Key Pair
#resource "aws_key_pair" "SSH-key" {
#  key_name   = "Shahid-eda-key"
#  public_key = file("~/.ssh/id_rsa.pub")
#}
#
#module "vpc" {
#  source = "./vpc"
#}
#
#module "ec2" {
#  source = "./ec2"
#  subnet_id = module.vpc.pvtcidrid
#  vpcid = module.vpc.pubcidrid
#}

data "external" "myip" {
  program = ["bash","curl http://ipconfig.io/ip"]
}

output "myip" {
  value = data.external.myip.result
}
#module "eks" {
#  source    = "./eks"
#  vpcid     = module.vpc.vpcid
#  pvtcidrid = module.vpc.pvtcidrid
#  pubcidrid = module.vpc.pubcidrid
#}
#output "cluster_endpoint" {
#  value = module.eks.cluster_endpoint
#}
#module "argocd" {
#  source                     = "../argocd"
#  eks_cluster_endpoint       = module.eks.cluster_endpoint
#  eks_cluster_ca_certificate = module.eks.cluster_certificate_authority_data
#  eks_token                  = module.eks.eks_token
#}

# module "lgtm" {
#   source = "../lgtm"
#   #depends_on = [ module.eks ]

# }