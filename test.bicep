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

module acs 'modules/communication-services.bicep' = {
  name: 'Deploy-ACS'
  scope: infrastructureResourceGroup
  params: {
    name: 'acs-xprtzbv'
    location: 'global'
  }
}
