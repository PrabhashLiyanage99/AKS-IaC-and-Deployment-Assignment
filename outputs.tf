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
