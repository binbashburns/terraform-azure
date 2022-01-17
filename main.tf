# This is my first Azure Terraform configuration!

# Invokes Resource Group module
module "rg" {
  source    = "./modules/rg"
  base_name = "tfAz"
  location  = "East US"
}

# Invoke Key Vault module
module "kv" {
  source   = "./modules/kv"
  location = "East US"
  rgName   = module.rg.rg_name_output
  rgId     = module.rg.rg_id
}

# Invokes Virtual Network Module
module "network" {
  source    = "./modules/network"
  base_name = "tfAz"
  location  = "East US"
  rgName    = module.rg.rg_name_output
  vnetCidr  = ["10.0.0.0/16"]
  snetCidr  = ["10.0.1.0/24"]

}

# Invokes Virtual Machine Module
module "vm" {
  source    = "./modules/vm"
  base_name = "tfAz"
  location  = "East US"
  rgName    = module.rg.rg_name_output
  size      = "Standard_DS1_v2"
  uName     = "tf-admin"
  pWd       = module.kv.randomKvPassword
  nic       = module.network.nic_output
}

# Invokes Storage Account Module
module "stgAcct" {
  source    = "./modules/stgAcct"
  base_name = "tfAz"
  location  = "East US"
  rgName    = module.rg.rg_name_output
}