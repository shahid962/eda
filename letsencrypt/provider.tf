terraform {
  required_providers {
    acme = {
      source  = "vancluever/acme"
      #version = "~> 2.18.0"
    }
  }
}

provider "acme" {
  server_url = "https://acme-staging-v02.api.letsencrypt.org/directory"
}