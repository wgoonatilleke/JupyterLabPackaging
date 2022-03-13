param JupyterLabBastionHost string
param location string
param JupyterLabVnet string

resource bastionHost 'Microsoft.Network/bastionHosts@2021-05-01' = {
  name: JupyterLabBastionHost
  location: location
  dependsOn: [
    JupyterLabVnet
  ]
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
            id: 'JupyterLabBastionIP'
          }
          subnet: {
            id: 
          }
        }
      }
    ]
    scaleUnits: 1
  }
}
