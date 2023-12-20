# Domain against which certificate will be created
# i.e. letsencrypt-terraform.example.com
variable "common_name" {}
#variable "demo_acme_challenge_aws_access_key_id"     { }
#variable "demo_acme_challenge_aws_secret_access_key" { }
#variable "demo_acme_challenge_aws_region"            { }
variable "acme_registration_email" {}
