output "kube_config" {
  value       =  azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive   = true
  description = "kubeconfig - access aks cluster"
}

output "cluster_name" {
  value       = azurerm_kubernetes_cluster.aks.name
  description = "aks cluster name"
}

output "resource_group_name" {
  value       = azurerm_resource_group.rg.name
  description = "resource group name"
}

output "cluster_location" {
  value       = azurerm_resource_group.rg.location
  description = "cluster location"
}

output "storage_account_name" {
  value       = azurerm_storage_account.storage.name
  description = "The name of the storage account"
}

output "storage_account_id" {
  value       = azurerm_storage_account.storage.id
  description = "The ID of the storage account"
}

output "storage_account_primary_access_key" {
  value       = azurerm_storage_account.storage.primary_access_key
  sensitive   = true
  description = "The primary access key for the storage account"
}