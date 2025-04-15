resource "azurerm_resource_group" "resource_group" {
  location = "uksouth"
  name     = "rg-${var.app_name}-func-${var.location}"
}

resource "random_string" "storage_account_suffix" {
  length  = 4
  upper   = false
  special = false
}

resource "azurerm_storage_account" "storage_account" {
  name                     = "sa${var.app_name}${var.location}${random_string.storage_account_suffix.result}"
  resource_group_name      = azurerm_resource_group.resource_group.name
  location                 = azurerm_resource_group.resource_group.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_application_insights" "app_insights" {
  name                = "appi-${var.app_name}-${var.location}"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  workspace_id        = var.log_analytics_workspace_id
  application_type    = "web"
}

resource "azurerm_service_plan" "service_plan" {
  name                = "asp-${var.app_name}-${var.location}"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  os_type             = "Linux"
  sku_name            = "FC1"
}

resource "azurerm_linux_function_app" "function_app" {
  name                        = "func-${var.app_name}-${var.location}"
  location                    = azurerm_resource_group.resource_group.location
  resource_group_name         = azurerm_resource_group.resource_group.name
  service_plan_id             = azurerm_service_plan.service_plan.id
  storage_account_name        = azurerm_storage_account.storage_account.name
  storage_account_access_key  = azurerm_storage_account.storage_account.primary_access_key
  https_only                  = true
  enabled                     = true
  functions_extension_version = "~4"
  client_certificate_mode     = "Required"

  site_config {
    scm_minimum_tls_version  = "1.2"
    application_insights_key = azurerm_application_insights.app_insights.instrumentation_key

    application_stack {
      dotnet_version = "8.0"
    }
  }

  app_settings = {
    "FUNCTIONS_WORKER_RUNTIME" = "dotnet"
  }
}
