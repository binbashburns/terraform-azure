# This is my first Azure Terraform configuration!

# Provides configuration details for Terraform
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.91.0"
    }
  }
}

# Provides configuration details for the Azure Terraform provider. 
# We don't have any features in this deployment, but if the features block isn't present, we get an error.
provider "azurerm" {
  features {}
}

# Provides the Resource Group to logically contain resources
resource "azurerm_resource_group" "rg" {
  name     = "tf-rg"
  location = "eastus"
}

# Provides Virtual Network 
resource "azurerm_virtual_network" "vnet" {
  name                = "tf-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Provides internal subnet within the Virtual Network for VM
resource "azurerm_subnet" "sn" {
  name                 = "tf-sn"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Provides NIC for VM to connect to internal subnet
resource "azurerm_network_interface" "nic" {
  name                = "tf-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.sn.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Provides Windows Virtual Machine in resource group
resource "azurerm_windows_virtual_machine" "vm" {
  name                  = "tf-vm"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  size                  = "Standard_DS1_v2"
  admin_username        = "tf-admin"
  admin_password        = "@pplyYourself123!"
  network_interface_ids = [azurerm_network_interface.nic.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}