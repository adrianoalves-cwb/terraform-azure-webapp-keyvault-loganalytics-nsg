
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

# Application Insights
variable "application_insights_name" {
  description = "The name of the Application Insights instance."
  type        = string
}

variable "application_insights_workspace_id" {
  description = "The workspace ID for the Application Insights instance."
  type        = string
}

