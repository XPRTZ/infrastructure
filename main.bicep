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

module deploymentsWriterRoleDefinitions 'modules/customroledefinitions.bicep' = {
  name: 'deployDeploymentsWriterRoleDefinitions'
}

module infrastructureRoleDefinitions 'modules/customroledefinitions.bicep' = {
  name: 'deployInfrastructureRoleDefinitions'
  params: {
    actions: [
      'Microsoft.Resources/deployments/write'
      'Microsoft.Cdn/*/write'
      'Microsoft.Network/dnsZones/*/write'
    ]
  }
}

module acrRoleAssignments 'modules/roleassignments.bicep' = {
  scope: acrResourceGroup
  name: 'deployAcrRoleAssignments'
  params: {
    deploymentsWriterRoleDefinitionId: deploymentsWriterRoleDefinitions.outputs.roleDefinitionId
  }
}

module infrastuctureRoleAssignments 'modules/roleassignments.bicep' = {
  scope: infrastructureResourceGroup
  name: 'deployInfrastuctureRoleAssignments'
  params: {
    deploymentsWriterRoleDefinitionId: infrastructureRoleDefinitions.outputs.roleDefinitionId
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
