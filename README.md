# AKS IaC and Deployment Assignment :computer:

This project demonstrates setting up an **Azure Kubernets Service (AKS) cluster** using **Terraform** and deploying a simple **Nginx application** via Kubernetes YAML manifests.

##  The steps took to set up the AKS cluster :feet:

### :one: check terraform version
Verify that the Terraform tool has been installed correctly

```sh
terraform --version
```
output:
```sh
PS C:\Users\Prabash> terraform --version
Terraform v1.11.2
on windows_amd64
```
### :two: Set Up Azure Authentication

```sh
az login
az account set --subscription "<SUBSCRIPTION_ID>"
```
output:
```sh
PS C:\Users\Prabash> az login
>> az account set --subscription "<SUBSCRIPTION_ID>"
Select the account you want to log in with. For more information on login with Azure CLI, see https://go.microsoft.com/fwlink/?linkid=2271136

Retrieving tenants and subscriptions for the selection...

[Tenant and subscription selection]

No     Subscription name    Subscription ID                       Tenant
-----  -------------------  ------------------------------------  -----------------
[1] *  Azure for Students   "<SUBSCRIPTION_ID>"                   Default Directory

The default is marked with an *; the default tenant is 'Default Directory' and subscription is 'Azure for Students' ("<SUBSCRIPTION_ID>").

Select a subscription and tenant (Type a number or Enter for no changes):

Tenant: Default Directory
Subscription: Azure for Students ("<SUBSCRIPTION_ID>")

[Announcements]
With the new Azure CLI login experience, you can select the subscription you want to use more easily. Learn more about it and its configuration at https://go.microsoft.com/fwlink/?linkid=2271236

If you encounter any problem, please open an issue at https://aka.ms/azclibug
```