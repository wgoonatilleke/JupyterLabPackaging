@description('Specifies the location for resources.')
param location string = 'eastus'

// === Create a Resource Group ===
targetScope = 'subscription'

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'testRG'
  location: location
}
