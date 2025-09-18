data "azurerm_key_vault" "keyvault" {
    for_each = var.keyvaultid
  name                = each.key
  resource_group_name = each.value.r_g_n
}


data "azurerm_key_vault_secret" "keyvaultsecret" {
  for_each = var.keyvaultsecret
  name         = each.key
  key_vault_id = data.azurerm_key_vault.keyvault[each.value.k_v_i].id
  
}