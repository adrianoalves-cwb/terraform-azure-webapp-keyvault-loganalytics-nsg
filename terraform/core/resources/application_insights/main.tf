resource "azurerm_application_insights" "app_insights" {
  name                = var.application_insights_name
  location            = var.location
  resource_group_name = var.resource_group_name
  application_type    = "web"
  workspace_id        = var.application_insights_workspace_id
  retention_in_days   = 90
  sampling_percentage = 0
  tags                = var.tags
}

