variable "cust_id" {
  description = "customer name"
  default     = "custA"
}

variable "env" {
  description = "environment description"
  default     = "a-a"
}

variable "vcn_cidr" {
  type    = string
  default = "10.0.0.0/24"
}

variable "vcn_nlb-pub_subnet_cidr" {
  type    = string
  default = "10.0.0.0/28"
}

variable "vcn_untrust_subnet_cidr" {
  type    = string
  default = "10.0.0.16/28"
}

variable "vcn_trust_subnet_cidr" {
  type    = string
  default = "10.0.0.32/28"
}

// OCI configuration
variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "private_key_path" {}
variable "fingerprint" {}
variable "compartment_ocid" {}
variable "region" {}
variable "private_key_password" {}

