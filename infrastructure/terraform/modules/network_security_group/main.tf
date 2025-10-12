# --- Network Security Groups

# Note: public ingress security checks ignored at this time
# The Microsoft lab is prescribing these being open.
#tfsec:ignore:azure-network-no-public-ingress tfsec:ignore:azure-network-disable-rdp-from-internet
resource "azurerm_network_security_group" "project_nsg" {
  name                = "nsg-${var.app_name}-${terraform.workspace}-1"
  location            = var.region
  resource_group_name = var.resource_group

  security_rule {
    name                                       = "allow-web-all"
    access                                     = "Allow"
    direction                                  = "Inbound"
    source_address_prefix                      = "*"
    source_port_range                          = "*"
    destination_application_security_group_ids = [var.asgs["web_security_group"]]
    destination_port_ranges                    = ["80", "443"]
    protocol                                   = "Tcp"
    priority                                   = 100
  }

  security_rule {
    name                                       = "allow-rdp-all"
    access                                     = "Allow"
    direction                                  = "Inbound"
    source_address_prefix                      = "*"
    source_port_range                          = "*"
    destination_application_security_group_ids = [var.asgs["mgmt_security_group"]]
    destination_port_range                     = "3389"
    protocol                                   = "Tcp"
    priority                                   = 110
  }

}

resource "azurerm_subnet_network_security_group_association" "project_nsg_subnet" {
  subnet_id                 = var.subnets["subnet-1"]
  network_security_group_id = azurerm_network_security_group.project_nsg.id
}