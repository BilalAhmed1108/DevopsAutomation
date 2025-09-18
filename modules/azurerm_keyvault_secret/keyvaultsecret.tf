resource "azurerm_key_vault_secret" "keyvaultsecret" {
  for_each = var.keyvaultsecret
  name         = each.key
  value = each.value.value
  key_vault_id = data.azurerm_key_vault.keyvaultid[each.value.k_v_i].id
  }




