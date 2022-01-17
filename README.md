# Terraform Project (Azure)
## This is Matt's first Azure project in Terraform!
This project creates the following resources:
- Resource Group
- Storage Account
- Key Vault
- Virtual Machine running Microsoft Windows Server 2016 Datacenter
  - Disk storage
  - Default username is defined in main.tf ("tf-admin" by default)
  - Password is stored in Azure Key Vault
- Virtual Network
  - Subnet
  - Network Interface