resource "azurerm_linux_virtual_machine" "vm" {
    for_each = var.vm
  name                = each.value.name
  resource_group_name = each.value.r_g_n
  location            = each.value.location
  size                = each.value.size
  admin_username     = data.azurerm_key_vault_secret.keyvaultsecret["${each.value.name}username"].value
  admin_password = data.azurerm_key_vault_secret.keyvaultsecret["${each.value.name}password"].value
  disable_password_authentication = each.value.d_p_a
  network_interface_ids = [
    data.azurerm_network_interface.nicdata[each.key].id,
  ]



  os_disk {
    caching              = each.value.caching
    storage_account_type = each.value.s_a_t
  }

  source_image_reference {
    publisher = each.value.publisher
    offer     = each.value.offer
    sku       = each.value.sku
    version   = each.value.version
  }
}