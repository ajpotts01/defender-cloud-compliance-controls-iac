resource "azurerm_application_security_group" "web_security_group" {
  name                = "asg-${var.app_name}-${terraform.workspace}-web"
  location            = var.region
  resource_group_name = var.resource_group
}

resource "azurerm_application_security_group" "mgmt_security_group" {
  name                = "asg-${var.app_name}-${terraform.workspace}-mgmt"
  location            = var.region
  resource_group_name = var.resource_group
}