# Auto-Scale GitHub Actions Runner Controller On AKS (Azure Kubernetes Service) 
This repo will demo shortly the following:
- Bicep deployment, which responsible to the following:
  - AKS deployment
  - Install GitHub Actions Runner Coontroller (ARC) on AKS with auto-scale configuration
- Deploying sample app to AKS cluster using without keeping any passowords on GitHub side

## Prerequisites
- Fork this repo to your github account
- In the forked repo [Configure OpenID Connect in Azure](https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-azure)

## IaC deployment using Bicep (Bash)
Excute the following commands:

``` 
region="westeurope"
az deployment sub create --name runnersonaks --location $region --template-file ./infra/main.bicep --parameters ./infra/main.parameters.json
```