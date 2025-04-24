output "region_code" {
  value = var.region_code
}

output "storage_account" {
  value = azurerm_storage_account.storage_account
}

output "application_insights" {
  value = azurerm_application_insights.app_insights
}

output "service_plan" {
  value = azurerm_service_plan.service_plan
}

output "function_app" {
  value = azurerm_linux_function_app.function_app
}
