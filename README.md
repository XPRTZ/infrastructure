# XPRTZ common infrastructure

## Azure Container Registry
Set up an Azure Container Registry (ACR) to store the container images. The ACR is used by Azure Container Apps to deploy the containers. Authentication is done via a managed identity/service principal. The managed identity is created in the Azure Container Apps resource group and should be assigned the role `AcrPull` on the ACR in order to be able to pull the images.
