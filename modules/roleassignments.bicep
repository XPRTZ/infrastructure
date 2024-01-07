var rbacAdminRoleDefinitionId = 'f58310d9-a9f6-439a-9e8d-f62e7b41a168'
var developersServicePrincipleId = 'xprtz-mgmt-developers-sp'

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
