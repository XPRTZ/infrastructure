targetScope = 'subscription'

param location string = 'westeurope'

var acrResourceGroupName = 'rg-xprtzbv-acr'
var infrastructureResourceGroupName = 'rg-xprtzbv-infrastructure'

resource acrResourceGroup 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: acrResourceGroupName
  location: location
}

resource infrastructureResourceGroup 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: infrastructureResourceGroupName
  location: location
}

module acr 'modules/acr.bicep' = {
  scope: acrResourceGroup
  name: 'deployAcr'
  params: {
    location: location
  }
}

module customRoleDefinitions 'modules/customroledefinitions.bicep' = {
  name: 'deployCustomRoleDefinitions'
}

module roleAssignments 'modules/roleassignments.bicep' = {
  scope: acrResourceGroup
  name: 'deployRoleAssignments'
  params: {
    deploymentsWriterRoleDefinitionId: customRoleDefinitions.outputs.roleDefinitionId
  }
}

module analytics 'modules/analytics.bicep' = {
  scope: infrastructureResourceGroup
  name: 'deployAnalytics'
}

module frontDoorProfile 'modules/frontDoorProfile.bicep' = {
  scope: infrastructureResourceGroup
  name: 'deployFrontDoorProfile'
  params: {
    logAnalyticsWorkspaceId: analytics.outputs.logAnalyticsWorkspaceId
  }
}
