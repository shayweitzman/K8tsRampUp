# Parameters the scripts requires to run. supply using "./deployment.ps1 -resourceGroupName <value>"
param(
[string]$subscriptionId,
[string]$location,
[string]$resourceGroupName,
[string]$clusterName,
[string]$namespace
)

#Set subscription
az account set --subscription $subscriptionId #"ee70519e-afca-47a8-910f-a7ebaf5850f0"

# Create resource group
az group create --location $location --name $resourceGroupName
    
# Create AKS cluster
az aks create --name $clusterName --resource-group $resourceGroupName

# Set kubectl context
az aks get-credentials --name $clusterName --resource-group $resourceGroupName

# Deploy NGINX ingress controller via helm. define the external traffic policy to local to allow request routing to the applications
helm upgrade --install my-first-release hello_world_chart
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx

helm install nginx-ingress ingress-nginx/ingress-nginx -n $namespace --set controller.service.externalTrafficPolicy=Local
