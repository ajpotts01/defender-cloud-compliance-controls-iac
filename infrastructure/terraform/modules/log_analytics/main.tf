resource "azurerm_log_analytics_workspace" "log_analytics" {
  name                = "${var.app_name}-log-analytics"
  location            = var.region
  resource_group_name = var.resource_group
  sku                 = "PerGB2018"
}

resource "azurerm_monitor_data_collection_rule" "collection_rule_main" {
  name                = "${var.app_name}-dcr-1"
  location            = var.region
  resource_group_name = var.resource_group
  kind                = "Windows"

  data_flow {
    destinations  = [azurerm_log_analytics_workspace.log_analytics.name]
    output_stream = "Microsoft-Event"
    streams       = ["Microsoft-Event"]
    transform_kql = "source"
  }

  data_sources {
    windows_event_log {
      name           = "winEvtLogs"
      streams        = ["Microsoft-Event"]
      x_path_queries = ["Application!*[System[(Level=1 or Level=2 or Level=3)]]", "Security!*[System[(band(Keywords,13510798882111488))]]", "System!*[System[(Level=1 or Level=2 or Level=3)]]"]
    }
  }

  destinations {
    log_analytics {
      name                  = azurerm_log_analytics_workspace.log_analytics.name
      workspace_resource_id = azurerm_log_analytics_workspace.log_analytics.id
    }
  }
}

resource "azurerm_monitor_data_collection_rule_association" "collection_rule_resources" {
  count                   = 2
  target_resource_id      = var.virtual_machines[count.index]
  data_collection_rule_id = azurerm_monitor_data_collection_rule.collection_rule_main.id
  name                    = "Virtual Machines"
  description             = "Windows VM logs"
}