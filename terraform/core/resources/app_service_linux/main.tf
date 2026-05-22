
resource "azurerm_linux_web_app" "app_service_linux" {
  name                = var.web_app_name
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = var.azurerm_service_plan_id

  https_only                    = true
  client_affinity_enabled       = true
  public_network_access_enabled = true
  virtual_network_subnet_id     = var.virtual_network_subnet_id

  tags = var.tags

  app_settings = var.web_app_app_settings

  identity {
    type = "SystemAssigned"
  }

  logs {
    detailed_error_messages = true
    failed_request_tracing  = true

    http_logs {
      file_system {
        retention_in_days = 0
        retention_in_mb   = 35
      }
    }
  }

  site_config {
    always_on               = false
    app_command_line        = null
    ftps_state              = "FtpsOnly"
    http2_enabled           = true
    minimum_tls_version     = "1.3"
    scm_minimum_tls_version = "1.2"
    use_32_bit_worker       = true
    vnet_route_all_enabled  = true
    websockets_enabled      = false
    worker_count            = 1

    dynamic "scm_ip_restriction" {
      for_each = var.web_app_scm_ip_restriction == null ? [] : [var.web_app_scm_ip_restriction]
      content {
        action     = scm_ip_restriction.value.action
        ip_address = scm_ip_restriction.value.ip_address
        name       = scm_ip_restriction.value.name
        priority   = scm_ip_restriction.value.priority
      }
    }

    application_stack {
      dotnet_version = var.dotnet_version
      node_version   = var.node_version
    }
  }
}

