resource "azurerm_virtual_network" "vnet" {
    for_each=var.vnet_variable
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.r_g_n
  address_space       = each.value.a_s
}



