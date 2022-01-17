variable "base_name" {
  type        = string
  description = "The base name for the Virtual Machine"
}

variable "location" {
  type        = string
  description = "The location for the deployment"
}

variable "rgName" {
  type        = string
  description = "Name of the resource group"
}

variable "size" {
  type        = string
  description = "SKU of the Virtual Machine"
}

variable "uName" {
  type        = string
  description = "Default admin username for VM"
}

variable "pWd" {
  type        = string
  description = "Default password for VM"
}

variable "nic" {
  description = "Network Interface card attached to VM"
}