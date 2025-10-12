resource "azurerm_virtual_network" "project_vnet" {
  name                = "vnet-${var.app_name}-${terraform.workspace}"
  location            = var.region
  resource_group_name = var.resource_group
  address_space       = ["10.0.0.0/16"]

  subnet {
    name = "subnet-1"
    # The Learn lab shows a lot on screen in terms of different fields
    # but under the hood it really just boils down to this one prefixes field.
    address_prefixes = ["10.0.0.0/24"]
  }
}