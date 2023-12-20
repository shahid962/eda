resource "tls_private_key" "acme_registration_private_key" {
  algorithm = "RSA"
}

# Set up a registration using the registration private key
resource "acme_registration" "reg" {
  account_key_pem = tls_private_key.acme_registration_private_key.private_key_pem
  email_address   = var.acme_registration_email
}
resource "acme_certificate" "certificate" {
  account_key_pem = acme_registration.reg.account_key_pem
  common_name = var.common_name
  dns_challenge {
    provider = "route53"
  }
}