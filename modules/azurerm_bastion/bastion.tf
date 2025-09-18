resource "azurerm_bastion_host" "bastionhost" {
    for_each = var.bastionhost
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.r_g_n

  ip_configuration {
    name                 = each.value.ip_name
    subnet_id            = data.azurerm_subnet.subnet[each.key].id
    public_ip_address_id = data.azurerm_public_ip.pip[each.value.p_i_a_i].id
  }
}

