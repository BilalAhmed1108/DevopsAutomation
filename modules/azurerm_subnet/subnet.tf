resource "azurerm_subnet" "subnet" {
    for_each = var.subnet
  name                 = each.value.name
  resource_group_name  = each.value.r_g_n
  virtual_network_name = each.value.v_n_n
  address_prefixes     = each.value.a_p

}