output "randomKvPassword" {
  value = azurerm_key_vault_secret.vmpassword.value
}