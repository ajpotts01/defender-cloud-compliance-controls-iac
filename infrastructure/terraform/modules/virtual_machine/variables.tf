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
  description = "Name of the resource group to create virtual machines in"
}

variable "subnets" {
  type        = map(string)
  description = "Subnets to assign network interfaces to"
}

variable "asgs" {
  type        = map(string)
  description = "Application security groups"
}