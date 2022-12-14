targetScope = 'subscription'

param location string = deployment().location

@minLength(1)
@maxLength(16)
@description('Prefix for all deployed resources')
param resourcegroup string

@description('AKS cluster name')
param aksclustername string

@description('AKS admin user')
param adminusername string

@description('SSH Public Key')
@secure()
param sshpublickey string

@description('Runner Managed Identity')
param runneridentity string

/* RESOURCE GROUP */
resource rg 'Microsoft.Resources/resourceGroups@2020-06-01' = {
  name: resourcegroup
  location: location
}

/* USER MANAGED IDENTITY */
module identity 'resources/managedid.bicep' = {
  name: '${rg.name}-identity'
  scope: rg
  params: {
    location: location
    managedIdentityName: runneridentity
  }
}

module aks 'resources/aks.bicep' = {
  name: aksclustername
  scope: rg
  params: {
    clusterName: aksclustername
    managedresourceid: identity.outputs.managedIdentityResourceId
    adminusername: adminusername
    location: location
    clusterDNSPrefix: aksclustername       
    sshPubKey: sshpublickey
  }
}

output aksclusterfqdn string = aks.outputs.aksclusterfqdn
output aksresourceid string = aks.outputs.aksresourceid
output aksresourcename string = aks.outputs.aksresourcename

