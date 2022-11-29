####################################
## NETWORK SETTINGS              ##
###################################


resource "oci_core_virtual_network" "my_vcn" {
  cidr_block     = var.vcn_cidr
  compartment_id = var.compartment_ocid
  display_name   = "${var.cust_id}_${var.env}_vcn"
  #dns_label      = "${var.cust_id}_${var.env}_vcn"
}

####################################
## NLB-PUB NETWORK SETTINGS       ##
####################################


resource "oci_core_route_table" "nlb-pub_routetable" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_virtual_network.my_vcn.id
  display_name   = "${var.cust_id}_${var.env}_nlb-pub-rt"

  route_rules {
    destination       = "0.0.0.0/0"
    network_entity_id = oci_core_internet_gateway.igw.id
  }
}

resource "oci_core_subnet" "nlb-pub_subnet" {
  cidr_block          = var.vcn_nlb-pub_subnet_cidr
  display_name        = "${var.cust_id}_${var.env}_nlb-pub-subnet"
  compartment_id      = var.compartment_ocid
  vcn_id              = oci_core_virtual_network.my_vcn.id
  route_table_id      = oci_core_route_table.nlb-pub_routetable.id
}

####################################
## Untrust NETWORK SETTINGS       ##
###################################

resource "oci_core_internet_gateway" "igw" {
  compartment_id = var.compartment_ocid
  display_name   = "${var.cust_id}_${var.env}_igw"
  vcn_id         = oci_core_virtual_network.my_vcn.id
}

resource "oci_core_route_table" "untrust_routetable" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_virtual_network.my_vcn.id
  display_name   = "${var.cust_id}_${var.env}_public-rt"

  route_rules {
    destination       = "0.0.0.0/0"
    network_entity_id = oci_core_internet_gateway.igw.id
  }
}

resource "oci_core_subnet" "untrust_subnet" {
  cidr_block          = var.vcn_untrust_subnet_cidr
  display_name        = "${var.cust_id}_${var.env}_untrust-subnet"
  compartment_id      = var.compartment_ocid
  vcn_id              = oci_core_virtual_network.my_vcn.id
  route_table_id      = oci_core_route_table.untrust_routetable.id
}


###############################
## TRUST NETWORK SETTINGS    ##
###############################

resource "oci_core_subnet" "trust_subnet" {
  cidr_block          = var.vcn_trust_subnet_cidr
  display_name        = "${var.cust_id}_${var.env}_trust"
  compartment_id      = var.compartment_ocid
  vcn_id              = oci_core_virtual_network.my_vcn.id
  route_table_id             = oci_core_route_table.trust_routetable.id
  prohibit_public_ip_on_vnic = true
}

resource "oci_core_route_table" "trust_routetable" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_virtual_network.my_vcn.id
  display_name   = "${var.cust_id}_${var.env}_routetable"
}




