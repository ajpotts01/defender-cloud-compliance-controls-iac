module "resource_group" {
  source   = "./resource_group"
  region   = var.region
  app_name = var.app_name
}