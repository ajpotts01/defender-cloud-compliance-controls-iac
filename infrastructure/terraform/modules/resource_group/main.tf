resource "azurerm_resource_group" "project_rg" {
  name     = "rg-${var.app_name}-${terraform.workspace}"
  location = var.region
}