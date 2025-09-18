resource "azurerm_public_ip" "pip" {
    for_each = var.pip
  name                = each.value.name
  resource_group_name = each.value.r_g_n
  location            = each.value.location
  allocation_method   = each.value.a_m

}


