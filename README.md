# AKS IaC and Deployment Assignment :computer:

This project demonstrates setting up an **Azure Kubernets Service (AKS) cluster** using **Terraform** and deploying a simple **Nginx application** via Kubernetes YAML manifests.

## Access the Application in Browser

```
 http://135.234.251.46
 ```
### Access the application via curl 
```sh
curl http://135.234.251.46:80
```
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
### :three: Initialize Terraform

```sh
 terraform init
 ```
 output:
```sh
PS D:\Projects\AKS IaC and Deployment Assignment> terraform init
Initializing the backend...
Initializing provider plugins...
- Reusing previous version of hashicorp/azurerm from the dependency lock file
- Reusing previous version of hashicorp/local from the dependency lock file 
- Using previously-installed hashicorp/azurerm v4.23.0
- Using previously-installed hashicorp/local v2.5.2

Terraform has been successfully initialized!
```
1. It downloards the Azure provider that is necessary to translate the Terraform instructions into API calls
2. It will create two more folders as well as a stste file.

If you futher want to validate if the configuration is correct, you can do so with the below command.

```sh
 terraform validate
 ```
 output:
```sh
PS D:\Projects\AKS IaC and Deployment Assignment> terraform validate
Success! The configuration is valid.
```
### :four: Apply Terraform

Terraform will perform a **dry-run** and will prompt you with a detailed summary.
```sh
 terraform plan
 ```
 output:
```sh
Plan: 3 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + cluster_name                       = "bistec-aks-assignment"
  + kube_config                        = (sensitive value)
  + storage_account_id                 = (known after apply)
  + storage_account_name               = "bistecproject123"
  + storage_account_primary_access_key = (sensitive value)
  ─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.       
Releasing state lock. This may take a few moments...
```
Once you are happy with the changes, you can create the resources for **real** with.

```sh
 terraform apply  
 or
 terraform apply -auto-approve

 ```
 output:
```sh
Acquiring state lock. This may take a few moments...
var.storage_account_name
  storage acc. name

  Enter a value: bistecproject123
<---------------------------------------------------------->
Releasing state lock. This may take a few moments...
Releasing state lock. This may take a few moments...

Apply complete! Resources: 3 added, 0 changed, 0 destroyed.

Apply complete! Resources: 3 added, 0 changed, 0 destroyed.
```
### Cleanup AKS cluster(If need)
```sh
terraform destroy -auto-approve
```

### :five: Configure kubectl to connect to AKS

kubeconfig is the kube configuration file for the newly created cluster.Inspect the cluster pods using the generated kubeconfig file.
```sh
 kubectlaz aks get-credentials --resource-group bistec-aks-resource-group --name bistec-aks-assignment
 kubectl get nodes
 ```
 output:
```sh
Merged "bistec-aks-assignment" as current context in C:\Users\Prabash\.kube\config
NAME                                 STATUS   ROLES    AGE   VERSION
aks-myprojects-36623590-vmss000000   Ready    <none>   13h   v1.30.10
```

##   How you deployed the app :package:

### :six: Deploying the application to AKS
we use two key YAML files:
1. deployment.yaml :arrow_right: Defines the application workload(replicasets etc..)
2. service.ymal :arrow_right: Exposes the application(loadbalancer etc..)

```sh
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
```
output:
```sh
PS D:\Projects\AKS IaC and Deployment Assignment> kubectl apply -f deployment.yaml
deployment.apps/nginx-deployment created
PS D:\Projects\AKS IaC and Deployment Assignment> kubectl apply -f service.yaml
service/nginx-service created
```
Re-running after creation gives this:

```sh
deployment.apps/nginx-deployment unchanged
service/nginx-service unchanged
```
### :seven: verify Deployment

```sh
kubectl get deployments
```
output:
```sh
PS D:\Projects\AKS IaC and Deployment Assignment> kubectl get deployments
NAME               READY   UP-TO-DATE   AVAILABLE   AGE
nginx-deployment   2/2     2            2           12h
```
Check running pods

```sh
kubectl get pods
```
output:
```sh
PS D:\Projects\AKS IaC and Deployment Assignment> kubectl get pods
>>
NAME                               READY   STATUS    RESTARTS   AGE
nginx-deployment-576c6b7b6-6kjcl   1/1     Running   0          12h
nginx-deployment-576c6b7b6-xh6ng   1/1     Running   0          12h
```
Check Service

```sh
kubectl get services
```
output:
```sh
PS D:\Projects\AKS IaC and Deployment Assignment> kubectl get services
>>
NAME            TYPE           CLUSTER-IP    EXTERNAL-IP      PORT(S)        AGE
nginx-service   LoadBalancer   10.0.64.225   135.234.251.46   80:30836/TCP   12h
```
### :eight: Test the app

```sh
 curl http://135.234.251.46
```
output:
```sh
PS D:\Projects\AKS IaC and Deployment Assignment> curl http://135.234.251.46
   
StatusCode        : 200
StatusDescription : OK
Content           : <!DOCTYPE html>
                    <html>
                    <head>
                    <title>Welcome to nginx!</title>
                    <style>
                    html { color-scheme: light dark; }
                    body { width: 35em; margin: 0 auto;
                    font-family: Tahoma, Verdana, Arial, sans-serif; }
                    </style...
RawContent        : HTTP/1.1 200 OK
                    Connection: keep-alive
                    Accept-Ranges: bytes
                    Content-Length: 615
                    Content-Type: text/html
                    Date: Sun, 23 Mar 2025 04:11:29 GMT
                    ETag: "67a34638-267"
                    Last-Modified: Wed, 05 Feb 2025 ...
Forms             : {}
Headers           : {[Connection, keep-alive], [Accept-Ranges, bytes], [Content-Length, 615], [Content-Type, text/html]...}
Images            : {}
InputFields       : {}
Links             : {@{innerHTML=nginx.org; innerText=nginx.org; outerHTML=<A href="http://nginx.org/">nginx.org</A>; outerText=nginx.org; tagName=A; href=http://nginx.org/},
                    @{innerHTML=nginx.com; innerText=nginx.com; outerHTML=<A href="http://nginx.com/">nginx.com</A>; outerText=nginx.com; tagName=A; href=http://nginx.com/}}
ParsedHtml        : mshtml.HTMLDocumentClass
RawContentLength  : 615
```
## Hiccups and how to identify them(Troubleshooting) :microscope:

### :one: Check AKS connectivity

If can't connect to AKS cluster, check AKS aonnectivity
```sh
az aks show --resource-group bistec-aks-resource-group --name bistec-aks-assignment --query "provisioningState"
```
output:
```sh
PS D:\Projects\AKS IaC and Deployment Assignment> az aks show --resource-group bistec-aks-resource-group --name bistec-aks-assignment --query "provisioningState"
>>
"Succeeded"
```
If it's "Failed" that is a configuration issue.

### :two: Check logs for issues

If the service is not accessible, check logs for issues
```sh
 kubectl describe pod nginx-deployment-576c6b7b6-6kjcl
```
```sh
output:
Name:             nginx-deployment-576c6b7b6-6kjcl
Namespace:        default
Priority:         0
Service Account:  default
Node:             aks-myprojects-36623590-vmss000000/10.224.0.4
Start Time:       Sat, 22 Mar 2025 21:17:27 +0530
Labels:           app=nginx
                  pod-template-hash=576c6b7b6
Annotations:      <none>
Status:           Running
IP:              <POD_PRIVATE_IP>
IPs:
  IP:           <POD_PRIVATE_IP>
Controlled By:  ReplicaSet/nginx-deployment-576c6b7b6
Containers:
  nginx:
    Container ID:   <CONTAINER_ID>
    Image:          nginx:latest
    Image ID:       <IMAGE_HASH>
    Port:           80/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Sat, 22 Mar 2025 21:17:32 +0530
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-vnsl7 (ro)
Conditions:
  Type                        Status
  PodReadyToStartContainers   True
  Initialized                 True
  Ready                       True
  ContainersReady             True
  PodScheduled                True
Volumes:
  kube-api-access-vnsl7:
  PodScheduled                True
  PodScheduled                True
Volumes:
  kube-api-access-vnsl7:
  PodScheduled                True
Volumes:
  kube-api-access-vnsl7:
  PodScheduled                True
Volumes:
  PodScheduled                True
Volumes:
  kube-api-access-vnsl7:
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:                      <none>
```
### File structure :open_file_folder:

```
AKS IAC AND DEPLOYMENT ASSIGNMENT/
|---.terraform
|   |-providers
|   |-terraform.tfstate
|
|---infrastructure
|   |-aks.tf
|   |-backend.tf
|   |-local.tf
|   |-main.tf
|   |-outputs.tf
|   |-provider.tf
|   |-resource_group.tf
|   |-storage_acc.tf
|   |-variables.tf
|
|---k8s-manifests
|   |-deployment.yaml
|   |-service.yaml
|
|---scripts
|   |-backend.sh
|   |-var.sh
|
|---.gitignore
|---.terraform.lock.hcl
|---kubeconfig.yaml
|---README.md
|---terraform.tfstate.backup
|---tfplan
```
### Contributor :technologist:
- *Prabhash Pramodha Liyanage*
- *Devops Engineer Intern*
- *Faculty of Information Technology*
- *University of Moratuwa*
- *prabhashpramodha99@gmail.com*