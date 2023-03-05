variable "appserviceplan" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string 
}

variable "appname" {
  type = string
}


output "webapp_url" {
  value = azurerm_app_service.appname.default_site_hostname
}

output "webapp_ips" {
  value = azurerm_app_service.appname.outbound_ip_addresses
}

output "webapp_site_credentials" {
  value = azurerm_app_service.appname.site_credential
}

output "webapp_test" {
  value = "https://${azurerm_app_service.appname.default_site_hostname}"
}

variable "azurermsubnetid" {
  type = string
}