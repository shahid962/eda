variable "tags" {
  type = map(string)
  default = {

    Environment = "dev"
    Owner       = "Shahid Raza"
    Project     = "Internal-EDA"
  }

}


variable "pvtcidrid" {}

variable "pubcidrid" {}

variable "vpcid" {

}
 