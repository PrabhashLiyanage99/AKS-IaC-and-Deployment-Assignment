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
    name     = "bistec-aks-resource-group"
    location = "East US"
}

resource "azurerm_kubernetes_cluster" "aks" {
    name                = "bistec-aks-assignment"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    dns_prefix          = "bistecakscluster"
    
    default_node_pool {
        name            = "myprojects"
        node_count      = 1
        vm_size         = "Standard_D2s_v3"
    }

    identity {
        type    = "SystemAssigned"
    }
}

output "kube_config" {
  value       = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive   = true
  description = "description"
}

