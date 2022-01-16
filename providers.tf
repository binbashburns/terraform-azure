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