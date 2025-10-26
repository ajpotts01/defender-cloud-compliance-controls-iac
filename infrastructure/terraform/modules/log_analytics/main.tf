resource "azurerm_log_analytics_workspace" "log_analytics" {
  name                = "${var.app_name}-log-analytics"
  location            = var.region
  resource_group_name = var.resource_group
  sku                 = "PerGB2018"
}