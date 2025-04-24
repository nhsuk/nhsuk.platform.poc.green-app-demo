resource "azurerm_linux_function_app" "function_app" {
  name                        = "${var.app_name}-${var.region_code}-func"
  location                    = var.resource_group.location
  resource_group_name         = var.resource_group.name
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
