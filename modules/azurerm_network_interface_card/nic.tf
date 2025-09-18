resource "azurerm_network_interface" "nic" {
    for_each = var.nic
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.r_g_n

  ip_configuration {
    name                          = each.value.ip_name
    subnet_id                     = data.azurerm_subnet.subnet[each.value.subnetid].id
    private_ip_address_allocation = each.value.p_i_a_a
  }
}


