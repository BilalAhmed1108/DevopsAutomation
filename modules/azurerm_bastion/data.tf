data "azurerm_public_ip" "pip" {
    for_each = var.pip
  name                = each.key
  resource_group_name = each.value
}


data "azurerm_subnet" "subnet" {
    for_each = var.subnet
  name                 = each.key
  virtual_network_name = each.value.v_n_n
  resource_group_name  = each.value.r_g_n
}