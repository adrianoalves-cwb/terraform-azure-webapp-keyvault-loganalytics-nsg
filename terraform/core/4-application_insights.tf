resource "azurerm_log_analytics_workspace" "workspace" {
  name                         = var.log_analytics_workspace_name
  location                     = var.location
  resource_group_name          = var.resource_group_name
  sku                          = var.log_analytics_sku
  retention_in_days            = var.log_analytics_retention_in_days
  local_authentication_enabled = var.local_authentication_enabled

  tags = var.tags

  depends_on = [azurerm_resource_group.rg]
}

module "app_insights_api" {
  source = "./resources/application_insights"

  application_insights_name         = var.application_insights_api_name
  location                          = var.location
  resource_group_name               = var.resource_group_name
  application_insights_workspace_id = azurerm_log_analytics_workspace.workspace.id
  tags                              = var.tags

  depends_on = [azurerm_resource_group.rg]
}

module "app_insights_ui" {
  source = "./resources/application_insights"

  application_insights_name         = var.application_insights_ui_name
  location                          = var.location
  resource_group_name               = var.resource_group_name
  application_insights_workspace_id = azurerm_log_analytics_workspace.workspace.id
  tags                              = var.tags

  depends_on = [azurerm_resource_group.rg]
}

resource "azurerm_monitor_action_group" "appinsights_smart_detection" {
  name                = var.appinsights_smart_detection_name
  resource_group_name = var.resource_group_name
  short_name          = var.appinsights_smart_detection_short_name
  enabled             = true

  arm_role_receiver {
    name                    = "Monitoring Contributor"
    role_id                 = var.appinsights_smart_detection_monitoring_contributor_id
    use_common_alert_schema = true
  }

  arm_role_receiver {
    name                    = "Monitoring Reader"
    role_id                 = var.appinsights_smart_detection_monitoring_reader_id
    use_common_alert_schema = true
  }

  tags = var.tags

  depends_on = [azurerm_resource_group.rg]
}
