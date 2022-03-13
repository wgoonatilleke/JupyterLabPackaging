
targetScope = 'subscription'

param subscriptionId string = subscription().subscriptionId
param location string = 'eastus'
param targetResourceGroup string = 'testRG'
param JupyterLabVnet string = 'JupyterLabVnet'
param JupyterLabSubnet string = 'JupyterLabSubnet'
param JupyterLabBastionIP string = 'JupyterLabBastionIP'
param JupyterLabBastionHost string = 'JupyterLabBastionHost'

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

module publicIp 'modules/publicIpAddress.bicep' = {
  name: 'publicIP-deployment'
  scope: resourceGroup(targetResourceGroup)
  params: {
    JupyterLabBastionIP : JupyterLabBastionIP
    location: location
  }
}

module bastionHost 'modules/bastionHost.bicep' = {
  name: 'bastionHost-deployment'
  scope: resourceGroup(targetResourceGroup)
  params: {
    JupyterLabBastionHost: JupyterLabBastionHost
    location: location
  }
}
