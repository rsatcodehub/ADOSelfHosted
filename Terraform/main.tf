data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "rg" {
  name     = var.rg_name
  location = var.location
}

resource "azurerm_virtual_network" "ado_agent_vnet" {
  name                = var.vnet_name
  address_space       = var.vnet_ip_address
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
}


resource "azurerm_subnet" "ado_agent_subnet" {
  name                 = var.subnet_name_ado_agent
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.ado_agent_vnet.name
  address_prefix       = var.ado_agent_subnet
}


# Create Random Password
resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

# Create Key Vault
resource "azurerm_key_vault" "ado_agent_kv" {
  name                        = var.kv_name
  location                    = azurerm_resource_group.rg.location
  resource_group_name         = azurerm_resource_group.rg.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    secret_permissions = [
      "Get", "Set", "List"
    ]
  }
}

resource "azurerm_key_vault_secret" "ado_agent_kv_secret" {
  name         = "lvm-ado-agent-password"
  value        = random_password.password.result
  key_vault_id = azurerm_key_vault.ado_agent_kv.id
}

