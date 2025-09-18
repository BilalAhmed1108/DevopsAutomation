data "azurerm_public_ip" "publicip" {
  name                = "bilalcorp-pip"
  resource_group_name = "bilalcorp-rg"
}