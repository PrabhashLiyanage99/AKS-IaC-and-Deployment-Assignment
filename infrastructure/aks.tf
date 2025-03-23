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