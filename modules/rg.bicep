
@description('Specifies the location for resources.')
param location string
param name string

targetScope = 'subscription'

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: name
  location: location
  
}
