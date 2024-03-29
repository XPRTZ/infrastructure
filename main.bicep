targetScope = 'subscription'

param location string = 'westeurope'

var acrResourceGroupName = 'rg-xprtzbv-acr'

resource acrResourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: acrResourceGroupName
  location: location
}

module acr 'modules/acr.bicep' = {
  scope: acrResourceGroup
  name: 'Deploy-Acr'
  params: {
    location: location
  }
}

module customRoleDefinitions 'modules/customroledefinitions.bicep' = {
  name: 'Deploy-Custom-RoleDefinitions'
}

module roleAssignments 'modules/roleassignments.bicep' = {
  scope: acrResourceGroup
  name: 'Deploy-Role-Assignments'
  params: {
    deploymentsWriterRoleDefinitionId: customRoleDefinitions.outputs.roleDefinitionId
  }
}
