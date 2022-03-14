// https://github.com/Azure/azure-quickstart-templates/blob/master/quickstarts/microsoft.network/azure-bastion/main.bicep

@description('Name of new or existing vnet to which Azure Bastion should be deployed')
param vnetName string = 'JupyterLabVnet'

@description('IP prefix for available addresses in vnet address space')
param vnetIpPrefix string = '10.0.0.0/16'

@description('Specify whether to provision new vnet or deploy to existing vnet')
@allowed([
  'new'
  'existing'
])
param vnetNewOrExisting string = 'existing'

@description('Bastion subnet IP prefix MUST be within vnet IP prefix address space')
param bastionSubnetIpPrefix string = '10.0.1.0/27'

@description('Name of Azure Bastion resource')
param bastionHostName string = 'JupyterLabBastionHost'

@description('Azure region for Bastion and virtual network')
param location string = resourceGroup().location

var publicIpAddressName = 'JupyterLabBastionHostPublicIP'
var bastionSubnetName = 'AzureBastionSubnet'

resource publicIp 'Microsoft.Network/publicIPAddresses@2021-05-01' = {
  name: publicIpAddressName
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}

// if vnetNewOrExisting == 'new', create a new vnet and subnet
resource newVirtualNetwork 'Microsoft.Network/virtualNetworks@2021-05-01' = if (vnetNewOrExisting == 'new') {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetIpPrefix
      ]
    }
    subnets: [
      {
        name: bastionSubnetName
        properties: {
          addressPrefix: bastionSubnetIpPrefix
        }
      }
    ]
  }
}

// if vnetNewOrExisting == 'existing', reference an existing vnet and create a new subnet under it
resource existingVirtualNetwork 'Microsoft.Network/virtualNetworks@2021-05-01' existing = if (vnetNewOrExisting == 'existing') {
  name: vnetName
}
resource subnet 'Microsoft.Network/virtualNetworks/subnets@2021-05-01' = if (vnetNewOrExisting == 'existing') {
  parent: existingVirtualNetwork
  name: bastionSubnetName
  properties: {
    addressPrefix: bastionSubnetIpPrefix
  }
}

resource bastionHost 'Microsoft.Network/bastionHosts@2021-05-01' = {
  name: bastionHostName
  location: location
  dependsOn: [
    newVirtualNetwork
    existingVirtualNetwork
  ]
  properties: {
    ipConfigurations: [
      {
        name: 'IpConf'
        properties: {
          subnet: {
            id: subnet.id
          }
          publicIPAddress: {
            id: publicIp.id
          }
        }
      }
    ]
  }
}
