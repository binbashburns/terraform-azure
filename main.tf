# This is my first Azure Terraform configuration!

# Invokes Resource Group module
module "rg" {
  source    = "./rg"
  base_name = "tfAz"
  location  = "East US"
}

# Invokes Virtual Network Module
module "network" {
  source    = "./network"
  base_name = "tfAz"
  location  = "East US"
  rgName    = module.rg.rg_name_output
  vnetCidr  = ["10.0.0.0/16"]
  snetCidr  = ["10.0.1.0/24"]

}

# Invokes Virtual Machine Module
module "vm" {
  source    = "./vm"
  base_name = "tfAz"
  location  = "East US"
  rgName    = module.rg.rg_name_output
  size      = "Standard_DS1_v2"
  uName     = "tf-admin"
  pWd       = "ChangeMe!9876"
  nic       = module.network.nic_output
}

# Invokes Storage Account Module
module "stgAcct" {
  source    = "./stgAcct"
  base_name = "tfAz"
  location  = "East US"
  rgName    = module.rg.rg_name_output
}