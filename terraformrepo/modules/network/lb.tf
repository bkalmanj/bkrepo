resource "azurerm_lb" "lb" {
  name = var.lbname
  location = var.location
  resource_group_name = var.resource_group_name

  frontend_ip_configuration {
    name = var.frontip 
    public_ip_address_id = var.pubip
  }
}

resource "azurerm_lb_backend_address_pool" "backlb" {
  name = var.backendlb
  loadbalancer_id = azurerm_lb.lb.id
}

resource "azurerm_lb_rule" "lbrule" {
  loadbalancer_id                = azurerm_lb.lb.id
  name                           = "LBRule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = azurerm_lb.lb.frontend_ip_configuration.name
}