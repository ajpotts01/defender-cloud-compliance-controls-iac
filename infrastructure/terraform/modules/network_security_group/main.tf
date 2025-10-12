# --- Network Security Groups

resource "azurerm_network_security_group" "project_nsg" {
  name                = "nsg-${var.app_name}-${terraform.workspace}-1"
  location            = var.region
  resource_group_name = var.resource_group
}

resource "azurerm_subnet_network_security_group_association" "project_nsg_subnet" {
  subnet_id                 = var.subnets["subnet-1"]
  network_security_group_id = azurerm_network_security_group.project_nsg.id
}