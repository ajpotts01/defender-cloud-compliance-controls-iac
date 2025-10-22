locals {
  num_vms = 2
}

# Reference: https://learn.microsoft.com/en-us/azure/virtual-machines/windows/quick-create-terraform
# The linked article gives an incorrect configuration.
# Valid configs:
# - sku = "Basic", allocation_method = "Dynamic"
# - sku = "Standard", allocation_method = "Static"
resource "azurerm_public_ip" "vm_public_ips" {
  count               = local.num_vms
  name                = "${var.app_name}-vm-${count.index + 1}-ip"
  location            = var.region
  resource_group_name = var.resource_group
  allocation_method   = "Dynamic"
  sku                 = "Basic"
}

resource "azurerm_network_interface" "vm_nics" {
  count               = local.num_vms
  name                = "${var.app_name}-${count.index + 1}-nic"
  location            = var.region
  resource_group_name = var.resource_group

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnets["subnet-1"]
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm_public_ips[count.index].id
  }
}

resource "random_password" "vm_passwords" {
  count       = local.num_vms
  length      = 20
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
  min_special = 1
  special     = true
}

resource "azurerm_windows_virtual_machine" "vms" {
  count               = local.num_vms
  name                = "vm-${count.index + 1}"
  resource_group_name = var.resource_group
  location            = var.region
  # Standard_D2s_v3-2 vcpus, 8 GiB memory.
  size = "Standard_D2s_v3"

  network_interface_ids = [azurerm_network_interface.vm_nics[count.index].id]

  # Don't actually use these...
  admin_username = "vm-${count.index}-admin"
  admin_password = random_password.vm_passwords[count.index].result

  os_disk {
    name                 = "${var.app_name}-vm-${count.index}-disk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-datacenter-azure-edition"
    version   = "latest"
  }

}

# Probably a better way to do this with a map or something
# Count is elegant enough for the above elements but not really for specific ASG assignment
resource "azurerm_network_interface_application_security_group_association" "vm_mgmt" {
  network_interface_id          = azurerm_network_interface.vm_nics[0].id
  application_security_group_id = var.asgs["mgmt_security_group"]
}

resource "azurerm_network_interface_application_security_group_association" "vm_web" {
  network_interface_id          = azurerm_network_interface.vm_nics[1].id
  application_security_group_id = var.asgs["web_security_group"]
}