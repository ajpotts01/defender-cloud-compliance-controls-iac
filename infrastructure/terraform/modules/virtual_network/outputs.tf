output "subnets" {
  value = {
    for s in azurerm_virtual_network.project_vnet.subnet : s.name => s.id
  }
}