# Provides Virtual Network 
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.base_name}Vnet"
  location            = var.location
  address_space       = var.vnetCidr
  resource_group_name = var.rgName
}

# Provides internal subnet within the Virtual Network for VM
resource "azurerm_subnet" "sn" {
  name                 = "${var.base_name}Snet"
  resource_group_name  = var.rgName
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.snetCidr
}

# Provides NIC for VM to connect to internal subnet
resource "azurerm_network_interface" "nic" {
  name                = "${var.base_name}nic"
  location            = var.location
  resource_group_name = var.rgName

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.sn.id
    private_ip_address_allocation = "Dynamic"
  }
}