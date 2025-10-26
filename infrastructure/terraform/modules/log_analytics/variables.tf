variable "region" {
  type        = string
  description = "Region to create resources in"
}

variable "app_name" {
  type        = string
  description = "App or project name - prefix for resources"
}

variable "resource_group" {
  type        = string
  description = "Name of the resource group to create virtual networks in"
}

variable "virtual_machines" {
  type        = list(string)
  description = "VMs to assign log collection to"
}