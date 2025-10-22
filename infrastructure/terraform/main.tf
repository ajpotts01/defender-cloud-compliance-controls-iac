module "resource_group" {
  source   = "./modules/resource_group"
  region   = var.region
  app_name = var.app_name
}

module "virtual_network" {
  source         = "./modules/virtual_network"
  region         = var.region
  app_name       = var.app_name
  resource_group = module.resource_group.resource_group_name
}

module "application_security_group" {
  source         = "./modules/application_security_group"
  region         = var.region
  app_name       = var.app_name
  resource_group = module.resource_group.resource_group_name
}

module "network_security_group" {
  source         = "./modules/network_security_group"
  region         = var.region
  app_name       = var.app_name
  resource_group = module.resource_group.resource_group_name
  subnets        = module.virtual_network.subnets
  asgs           = module.application_security_group.application_security_groups
}

module "virtual_machine" {
  source         = "./modules/virtual_machine"
  region         = var.region
  app_name       = var.app_name
  resource_group = module.resource_group.resource_group_name
  subnets        = module.virtual_network.subnets
  asgs           = module.application_security_group.application_security_groups
}