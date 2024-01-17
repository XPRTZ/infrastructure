param deploymentsWriterRoleDefinitionId string

var rbacAdminRoleDefinitionId = 'f58310d9-a9f6-439a-9e8d-f62e7b41a168'
var acrPushRoleDefinitionId = '8311e382-0749-4cb8-b61a-304f252e45ec'
var developersServicePrincipleId = '1f0f1bf8-45c6-451c-b6b5-f3ed8c38ef69'

// Role Based Access Control Administrator for xprtz-mgmt-developers-sp
resource rbacAdminAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  scope: resourceGroup()
  name: guid(developersServicePrincipleId, rbacAdminRoleDefinitionId, resourceGroup().id)
  properties: {
    principalId: developersServicePrincipleId
    roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', rbacAdminRoleDefinitionId)
    principalType: 'ServicePrincipal'
  }
}

// Deployments Writer for xprtz-mgmt-developers-sp
resource deploymentsWriterAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  scope: resourceGroup()
  name: guid(developersServicePrincipleId, deploymentsWriterRoleDefinitionId, resourceGroup().id)
  properties: {
    principalId: developersServicePrincipleId
    roleDefinitionId: deploymentsWriterRoleDefinitionId
    principalType: 'ServicePrincipal'
  }
  dependsOn: [
    rbacAdminAssignment
  ]
}

resource acrPushRoleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  scope: resourceGroup()
  name: guid(developersServicePrincipleId, acrPushRoleDefinitionId, resourceGroup().id)
  properties: {
    principalId: developersServicePrincipleId
    roleDefinitionId: acrPushRoleDefinitionId
    principalType: 'ServicePrincipal'
  }
  dependsOn: [
    deploymentsWriterAssignment
  ]
}
