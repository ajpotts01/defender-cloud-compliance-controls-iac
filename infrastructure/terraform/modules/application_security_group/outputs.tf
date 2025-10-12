output "application_security_groups" {
  value = {
    "web_security_group"  = azurerm_application_security_group.web_security_group.id
    "mgmt_security_group" = azurerm_application_security_group.mgmt_security_group.id
  }
}