resource "azurerm_lb" "loadbalancer" {
  name                = "BilalCorpLoadBalancer"
  location            = "australiaeast"
  resource_group_name = "bilalcorp-rg"

  frontend_ip_configuration {
    name                 = "NetflixPublicIPAddress"
    public_ip_address_id = data.azurerm_public_ip.publicip.id
  }
}




resource "azurerm_lb_backend_address_pool" "pool1" {
  loadbalancer_id = azurerm_lb.loadbalancer.id
  name            = "lb-BackEndAddressPool1"
}

resource "azurerm_lb_probe" "probe" {
  loadbalancer_id = azurerm_lb.loadbalancer.id
  name            = "netflix-probe"
  port            = 80
}

# Ip and Port Based Routing
resource "azurerm_lb_rule" "rule" {
  loadbalancer_id                = azurerm_lb.loadbalancer.id
  name                           = "LBRule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "NetflixPublicIPAddress"
}