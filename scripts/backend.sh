#!/bin/bash

RESOURCE_GROUP_NAME="bistec-aks-resource-group"
STORAGE_ACCOUNT_NAME="bistecaks$RANDOM"
CONTAINER_NAME="tfstate"
LOCATION="East US"

#create resource group
echo "Creating Resource Group:$RESOURCE_GROUP_NAME"
az group create --name $RESOURCE_GROUP_NAME --location "$LOCATION"

#create storage account
echo "Creating Storage Account:$STORAGE_ACCOUNT_NAME"
az storage account create --resource-group $RESOURCE_GROUP_NAME \
    --name $STORAGE_ACCOUNT_NAME \
    --sku Standard_LRS \
    --encryption-services blob \
    --allow-blob-public-access false

#create blob container
echo "Creating storage container:$CONTAINER_NAME"
az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME

STORAGE_KEY=$(az storage account keys list --resource-group $RESOURCE_GROUP_NAME --account-name $STORAGE_ACCOUNT_NAME --query '[0].value' --output tsv)

echo "storage account created"
echo "storage account name: $STORAGE_ACCOUNT_NAME"
echo "storage container: $CONTAINER_NAME"
echo "storage key: $STORAGE_KEY"

#backend configuration
cat <<EOF> backend.tf
terraform {
    backend "azurerm" {
        resource_group_name     = "$RESOURCE_GROUP_NAME"
        storage_account_name    = "$STORAGE_ACCOUNT_NAME"
        container_name          = "$CONTAINER_NAME"
        key                     = "terraform.tfstate"
    }
}
EOF

echo "backend configuration written to backend.tf"