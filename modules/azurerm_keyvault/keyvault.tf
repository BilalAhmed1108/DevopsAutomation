data "azurerm_client_config" "current" {}


resource "azurerm_key_vault" "keyvault" {
    for_each = var.keyvault
  name                        = each.value.name
  location                    = each.value.location
  resource_group_name         = each.value.r_g_n
  enabled_for_disk_encryption = each.value.e_f_d_e
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = each.value.s_d_r_d
  purge_protection_enabled    = each.value.p_p_e

  sku_name = each.value.s_n
enable_rbac_authorization = each.value.r_a_e
#rbac_authorization_enabled = true
  
}


resource "azurerm_role_assignment" "keyvult_admin" {
    depends_on = [ azurerm_key_vault.keyvault ]
    for_each = var.keyvault
  scope                = azurerm_key_vault.keyvault[each.key].id
  role_definition_name = each.value.r_d_n
  principal_id         = data.azurerm_client_config.current.object_id
}