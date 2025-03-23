terraform {
    backend "azurerm" {
        resource_group_name     = "bistec-aks-resource-group"
        storage_account_name    = "bistecaks32668"
        container_name          = "tfstate"
        key                     = "terraform.tfstate"
    }
}
