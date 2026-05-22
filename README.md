# Terraform Infrastructure (Production)

This repository contains Terraform code for provisioning and validating the application Azure infrastructure in Terraform Cloud workspaces.

## What This Deploys

The configuration in [terraform/core](terraform/core) provisions:

1. Resource group.
2. App Service Plan (Linux).
3. Two Linux Web Apps:
	- API app (.NET stack, VNet integration enabled).
	- UI app (Node.js stack).
4. Key Vault with configurable access policies.
5. Log Analytics Workspace.
6. Two Application Insights instances (API and UI) linked to the workspace.
7. Monitor Action Group for Application Insights Smart Detection notifications.
8. Network Security Group in the target resource group.

It also reads an existing VNet/subnet from another resource group and uses that subnet for API web app VNet integration.

## Repository Structure

- [terraform/core/0-basic.tf](terraform/core/0-basic.tf): resource group.
- [terraform/core/1-network.tf](terraform/core/1-network.tf): existing VNet/subnet lookups and NSG.
- [terraform/core/2-webapp.tf](terraform/core/2-webapp.tf): service plan and API/UI web app modules.
- [terraform/core/3-key_vault.tf](terraform/core/3-key_vault.tf): Key Vault module.
- [terraform/core/4-application_insights.tf](terraform/core/4-application_insights.tf): Log Analytics, Application Insights modules, and action group.
- [terraform/core/resources](terraform/core/resources): reusable Terraform modules.
- [terraform-init.yaml](terraform-init.yaml): shared Azure DevOps Terraform init/auth/validate steps.
- [yaml/terraform.yml](yaml/terraform.yml): Azure DevOps validation pipeline.

## Requirements

- Terraform version 1.6.0 or later.
- Providers:
  - hashicorp/azurerm >= 4.16.0
  - azure/azapi >= 2.2.0
- Access to Terraform Cloud organization VolvoGroup-Internal.
- Azure permissions to create resources in the target resource group and read the referenced VNet/subnet resource group.

## Required Input Variables

Core variables are defined in [terraform/core/variables.tf](terraform/core/variables.tf).

### Identity and scope

- tenant_id
- location
- resource_group_name
- tags

### Networking

- virtual_network_resource_group_name
- virtual_network_name
- subnet_name
- network_security_group_name

### App Service and apps

- service_plan_name
- service_plan_os_type
- service_plan_sku_name
- web_app_api_name
- web_app_api_app_settings
- dotnet_version
- web_app_ui_name
- web_app_ui_app_settings
- node_version

### Key Vault

- key_vault_name
- key_vault_access_policies

### Observability

- log_analytics_workspace_name
- log_analytics_sku
- log_analytics_retention_in_days
- local_authentication_enabled
- application_insights_api_name
- application_insights_ui_name
- appinsights_smart_detection_name
- appinsights_smart_detection_short_name
- appinsights_smart_detection_monitoring_contributor_id
- appinsights_smart_detection_monitoring_reader_id

## Outputs

Currently exposed outputs in [terraform/core/outputs.tf](terraform/core/outputs.tf):

- resource_group_name
- resource_group_location

Module output in [terraform/core/resources/key_vault/outputs.tf](terraform/core/resources/key_vault/outputs.tf):

- key_vault_id

## Local Workflow

Run from [terraform/core](terraform/core):

1. terraform init
2. terraform validate
3. terraform plan
4. terraform apply

If you use Terraform Cloud remote execution, ensure the selected workspace has all required variables configured.

## CI Validation Pipeline

Pipeline definition: [yaml/terraform.yml](yaml/terraform.yml)

What it does:

1. Selects Terraform workspace by branch:
	- main -> application-prod
	- qa -> application-qa
2. Runs shared steps from [terraform-init.yaml](terraform-init.yaml):
	- Install/upgrade Terraform.
	- Authenticate Terraform Cloud using TFC_TOKEN.
	- Set TF_WORKSPACE.
	- Run terraform init.
	- Run terraform validate.

## Notes

- API web app uses the existing subnet for VNet integration.
- UI web app does not set subnet integration in current configuration.
- Both web apps are created with system-assigned managed identity.
- Key Vault currently allows public network access and sets default_action to Allow in network ACLs.