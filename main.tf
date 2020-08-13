provider "azurerm" {
  version = "~> 2.22.0"
  features {}
}



variable "resource_group_name" {
  default = "terraform-demo"
  description = "The name of the resource group"
}

variable "resource_group_location" {
  default = "westeurope"
  description = "The location of the resource group"
}

variable "app_service_plan_name" {
  default     = "kursus-hardware"
  description = "The name of the app service plan"
}

variable "app_service_name_prefix" {
  default     = "az400"
  description = "The beginning part of the app service name"
}

resource "random_integer" "app_service_name_suffix" {
  min = 1000
  max = 9999
}

resource "azurerm_resource_group" "kursus" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

resource "azurerm_app_service_plan" "kursus" {
  name                = var.app_service_plan_name
  location            = azurerm_resource_group.kursus.location
  resource_group_name = azurerm_resource_group.kursus.name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Basic"
    size = "B1"
  }
}

resource "azurerm_app_service" "kursus" {
  name                = "${var.app_service_name_prefix}-${random_integer.app_service_name_suffix.result}"
  location            = azurerm_resource_group.kursus.location
  resource_group_name = azurerm_resource_group.kursus.name
  app_service_plan_id = azurerm_app_service_plan.kursus.id
  https_only          = "true"
  connection_string   {
    name  = "default"
    type  = "SQLAzure"
    value = "todo"
  }
  site_config {
    http2_enabled = "true"
    always_on     = "true"
  }


}

output "website_hostname" {
  value       = azurerm_app_service.kursus.default_site_hostname
  description = "The hostname of the website"
}