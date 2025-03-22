terraform {
  required_providers {
    azurerm = {
        source  = "hashicorp/azurerm"
        version = "~> 4.23.0"
    }
  }
  required_version = ">= 1.9.0"
}

provider "azurerm" {
    features {}
}

resource "azurerm_resource_group" "rg" {
    name     = var.resource_group_name
    location = var.location
}

resource "azurerm_kubernetes_cluster" "aks" {
    name                = var.aks_cluster_name
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    dns_prefix          = var.dns_prefix
    
    default_node_pool {
        name            = "myprojects"
        node_count      = var.node_count
        vm_size         = var.vm_size
    }

    identity {
        type    = "SystemAssigned"
    }
}

# output "kube_config" {
#   value       = azurerm_kubernetes_cluster.aks.kube_config_raw
#   sensitive   = true
#   description = "description"
# }

resource "local_file" "kubeconfig" {
  content   = azurerm_kubernetes_cluster.aks.kube_config_raw
  filename  = "kubeconfig.yaml"
}

