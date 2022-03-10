
targetScope = 'subscription'

param subscriptionId string = subscription().subscriptionId
param location string = 'eastus'
param targetResourceGroup string = 'testRG'

module rg 'modules/rg.bicep' = {
  name: 'resourceGroup-deployment'
  scope: subscription(subscriptionId)
  params: {
    name: targetResourceGroup
    location: location
  }
}
