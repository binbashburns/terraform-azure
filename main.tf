# This is my first Terraform configuration!

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

# Provides configuration details for the Azure Terraform provider
provider "azurerm" {
  features {}
}

# Provides the Resource Group to logically contain resources
resource "azurerm_resource_group" "rg" {
  name     = "tf-rg"
  location = "eastus"
  tags = {
    environment = "dev"
    source      = "Terraform"
  }
}
