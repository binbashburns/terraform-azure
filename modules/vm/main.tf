# Provides Windows Virtual Machine in resource group
resource "azurerm_windows_virtual_machine" "vm" {
  name                  = "${var.base_name}Vm"
  location              = var.location
  resource_group_name   = var.rgName
  size                  = var.size
  admin_username        = var.uName
  admin_password        = var.pWd
  network_interface_ids = [var.nic]

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