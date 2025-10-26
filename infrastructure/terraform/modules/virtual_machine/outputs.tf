output "virtual_machines" {
  value = azurerm_windows_virtual_machine.vms.*.id
}