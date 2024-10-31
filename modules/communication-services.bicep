param name string
param location string

resource acs 'Microsoft.Communication/communicationServices@2023-04-01' = {
  name: name
  location: location
   properties: {
     dataLocation: 'Europe'
   }
}
