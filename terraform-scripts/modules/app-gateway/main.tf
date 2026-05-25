resource "azurerm_public_ip" "appgw_pip" {
  name                = var.public_ip_name
  location            = var.location
  resource_group_name = var.resource_group_name

  allocation_method = "Static"
  sku               = "Standard"
}

resource "azurerm_application_gateway" "appgw" {
  name                = var.app_gateway_name
  resource_group_name = var.resource_group_name
  location            = var.location

  sku {
    name     = "WAF_v2"
    tier     = "WAF_v2"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "gateway-ip-config"
    subnet_id = var.subnet_id
  }

  frontend_port {
    name = "http-port"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "frontend-ip"
    public_ip_address_id = azurerm_public_ip.appgw_pip.id
  }

  backend_address_pool {
  name = "frontend-pool"

  ip_addresses = [var.frontend_vm_ip]
  }

  backend_address_pool {
    name = "api-pool"

    ip_addresses = [var.api_vm_ip]
  }

  backend_http_settings {
    name                  = "http-setting"
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 30
  }

  http_listener {
    name                           = "frontend-listener"
    frontend_ip_configuration_name = "frontend-ip"
    frontend_port_name             = "http-port"
    protocol                       = "Http"
    host_name                      = var.frontend_domain
  }

  http_listener {
    name                           = "api-listener"
    frontend_ip_configuration_name = "frontend-ip"
    frontend_port_name             = "http-port"
    protocol                       = "Http"
    host_name                      = var.api_domain
  }

  request_routing_rule {
    name                       = "frontend-rule"
    rule_type                  = "Basic"
    http_listener_name         = "frontend-listener"
    backend_address_pool_name  = "frontend-pool"
    backend_http_settings_name = "http-setting"
    priority                   = 100
  }

  request_routing_rule {
    name                       = "api-rule"
    rule_type                  = "Basic"
    http_listener_name         = "api-listener"
    backend_address_pool_name  = "api-pool"
    backend_http_settings_name = "http-setting"
    priority                   = 110
  }

  firewall_policy_id = var.waf_policy_id
}