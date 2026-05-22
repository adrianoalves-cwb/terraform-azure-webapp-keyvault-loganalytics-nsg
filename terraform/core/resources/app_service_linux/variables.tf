
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
variable "azurerm_service_plan_id" {
  description = "The ID of the app service plan."
  type        = string
}

#Web app
variable "web_app_name" {
  description = "The name of the web app."
  type        = string
}
variable "web_app_app_settings" {
  description = "A map of app settings to assign to the web app."
  type        = map(string)
  default     = null
}

variable "web_app_scm_ip_restriction" {
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
  type    = string
  default = null
}

variable "node_version" {
  type    = string
  default = null
}

#Virtual network
variable "virtual_network_subnet_id" {
  description = "The ID of the virtual network subnet."
  type        = string
  default     = null
}
