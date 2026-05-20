output "resource_group_name" {
  description = "Resource Group name"
  value       = azurerm_resource_group.main.name
}

output "vm_name" {
  description = "Linux VM name"
  value       = azurerm_linux_virtual_machine.main.name
}

output "public_ip_address" {
  description = "Public IP for SSH"
  value       = azurerm_public_ip.main.ip_address
}

output "ssh_connection_hint" {
  description = "Helpful SSH command"
  value       = "ssh ${var.admin_username}@${azurerm_public_ip.main.ip_address}"
}
