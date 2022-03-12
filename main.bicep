
targetScope = 'subscription'

param subscriptionId string = subscription().subscriptionId
param location string = 'eastus'
param targetResourceGroup string = 'testRG'
param JupyterLabVnet string
param JupyterLabSubnet string

module rg 'modules/rg.bicep' = {
  name: 'resourceGroup-deployment'
  scope: subscription(subscriptionId)
  params: {
    name: targetResourceGroup
    location: location
  }
}

module virualNetowrk 'modules/virtualNetwork.bicep' = {
  name: 'virtualNetowrk-deployment'
  scope: resourceGroup(targetResourceGroup)
  params: {
    JupyterLabVnet: JupyterLabVnet
    JupyterLabSubnet: JupyterLabSubnet
    location: location
  }
}
