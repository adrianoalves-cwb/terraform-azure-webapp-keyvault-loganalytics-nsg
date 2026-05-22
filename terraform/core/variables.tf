# Common variables
variable "tenant_id" {
  description = "The tenant ID for the Key Vault."
  type        = string
}

# Subnet
variable "subnet_name" {
  description = "The name of the subnet name."
  type        = string
}

#Virtual network
variable "network_security_group_name" {
  description = "The name of the network security group."
  type        = string
}

variable "virtual_network_name" {
  description = "The name of the virtual network."
  type        = string
}

variable "virtual_network_resource_group_name" {
  description = "The name of the resource group for the virtual network."
  type        = string
}

#Resource group
variable "location" {
  description = "The location of the resource group."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
}

#App service plan
variable "service_plan_name" {
  description = "The name of the app service plan."
  type        = string
}

variable "service_plan_os_type" {
  description = "The OS type of the app service plan."
  type        = string
}

variable "service_plan_sku_name" {
  description = "The SKU name of the app service plan."
  type        = string
}

#Web app API
variable "web_app_api_name" {
  description = "The name of the web app API."
  type        = string
}

variable "web_app_api_app_settings" {
  description = "A map of app settings to assign to the web app API."
  type        = map(string)
}

variable "web_app_api_scm_ip_restriction" {
  description = "Optional SCM IP restriction rule"
  type = object({
    action     = string
    ip_address = string
    name       = string
    priority   = number
  })
  default = null
}

variable "dotnet_version" {
  description = "The version of .NET to use."
  type        = string
}

#Web app UI
variable "web_app_ui_name" {
  description = "The name of the web app UI."
  type        = string
}

variable "web_app_ui_app_settings" {
  description = "A map of app settings to assign to the web app UI."
  type        = map(string)
}

variable "node_version" {
  description = "The version of Node.js to use."
  type        = string
}

#Key vault
variable "key_vault_name" {
  description = "The name of the Key Vault."
  type        = string
}

variable "key_vault_access_policies" {
  type = list(object({
    tenant_id               = string
    object_id               = string
    key_permissions         = list(string)
    secret_permissions      = list(string)
    certificate_permissions = list(string)
    storage_permissions     = list(string)
  }))
}

# Application Insights API
variable "application_insights_api_name" {
  description = "The name of the Application Insights instance."
  type        = string
}

# Application Insights UI
variable "application_insights_ui_name" {
  description = "The name of the Application Insights instance."
  type        = string
}

# Application Insights workspace
variable "log_analytics_workspace_name" {
  description = "The name of the Log Analytics workspace."
  type        = string
}

variable "log_analytics_sku" {
  description = "The SKU of the Log Analytics workspace."
  type        = string
}

variable "log_analytics_retention_in_days" {
  description = "The retention period for the Log Analytics workspace in days."
  type        = number
}

variable "local_authentication_enabled" {
  description = "Indicates whether local authentication is enabled for the Log Analytics workspace."
  type        = bool
}

# Application Insights Smart Detection action group
variable "appinsights_smart_detection_name" {
  description = "The name of the Application Insights Smart Detection action group."
  type        = string
}

variable "appinsights_smart_detection_short_name" {
  description = "The short name of the Application Insights Smart Detection action group."
  type        = string
}

variable "appinsights_smart_detection_monitoring_contributor_id" {
  description = "The ID of the Monitoring Contributor role for the Application Insights Smart Detection action group."
  type        = string
}

variable "appinsights_smart_detection_monitoring_reader_id" {
  description = "The ID of the Monitoring Reader role for the Application Insights Smart Detection action group."
  type        = string
}

