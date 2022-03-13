param JupyterLabBastionHost string
param location string

resource bastionHost 'Microsoft.Network/bastionHosts@2021-05-01' = {
  name: JupyterLabBastionHost
  location: location
  tags: {
    tagName1: 'tagValue1'
    tagName2: 'tagValue2'
  }
  sku: {
    name: 'Standard'
  }
  properties: {
    disableCopyPaste: false
    dnsName: 'string'
    enableFileCopy: true
    enableIpConnect: true
    enableShareableLink: true
    enableTunneling: true
    ipConfigurations: [
      {
        id: 'string'
        name: 'string'
        properties: {
          privateIPAllocationMethod: 'Static'
          publicIPAddress: {
            id: '/subscriptions/aaebfa4f-a706-4605-a6e3-f7a258f09c7f/resourceGroups/testRG/providers/Microsoft.Network/publicIPAddresses/JupyterLabBastionIP'
          }
          subnet: {
            id: '/subscriptions/aaebfa4f-a706-4605-a6e3-f7a258f09c7f/resourceGroups/testRG/providers/Microsoft.Network/virtualNetworks/JupyterLabVnet/subnets/AzureBastionSubnet'
          }
        }
      }
    ]
    scaleUnits: 1
  }
}
