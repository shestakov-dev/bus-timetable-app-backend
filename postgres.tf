resource "azurerm_postgresql_flexible_server" "pg-server" {
  name                   = var.postgres_server_name
  resource_group_name    = azurerm_resource_group.rg.name
  location               = azurerm_resource_group.rg.location
  version                = var.postgres_version
  administrator_login    = var.postgres_administrator_login
  administrator_password = var.postgres_administrator_password
  storage_mb             = 32768
  sku_name               = "GP_Standard_D4s_v3"
}

resource "azurerm_postgresql_flexible_server_database" "pg-database" {
  name      = var.postgres_database_name
  server_id = azurerm_postgresql_flexible_server.pg-server.id
  collation = "en_US.utf8"
  charset   = "UTF8"

  # prevent the possibility of accidental data loss
  lifecycle {
    prevent_destroy = true
  }
}
