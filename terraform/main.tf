
#Creating new Key Pair
resource "aws_key_pair" "SSH-key" {
  key_name   = "Shahid-eda-key"
  public_key = file("~/.ssh/id_rsa.pub")
}
module "vpc" {
  source = "./vpc"
}
module "eks" {
  source    = "./eks"
  vpcid     = module.vpc.vpcid
  pvtcidrid = module.vpc.pvtcidrid
  pubcidrid = module.vpc.pubcidrid
}