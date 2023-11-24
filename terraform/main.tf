
#Creating new Key Pair
resource "aws_key_pair" "SSH-key" {
  key_name   = "Shahid-eda-key"
  public_key = file("~/.ssh/id_rsa.pub")
}
module "vpc" {
  source = "./vpc"

}