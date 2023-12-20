variable "tags" {
  type = map(string)
  default = {

    Environment = "dev"
    Owner       = "Shahid Raza"
    Project     = "Internal-EDA"
  }

}

variable "vpccidr" {
  type    = string
  default = "10.0.0.0/16"

}
variable "pvtcidr" {
  type    = string
  default = "10.0.1.0/24"
}
variable "pubcidr" {
  type    = string
  default = "10.0.0.0/24"
}
variable "az1" {
  type    = string
  default = "us-east-1a"
}
variable "az2" {
  type    = string
  default = "us-east-1b"
}
