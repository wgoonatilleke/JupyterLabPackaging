
param JupyterLabVnet string = 'JupyterLabVnet'
param location string = 'eastus'
param JupyterLabSubnet string = 'JupyterLabSubnet'

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2021-05-01' = {
  name: JupyterLabVnet
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        name: JupyterLabSubnet
        properties: {
          addressPrefix: '10.0.0.0/24'
        }
      }
    ]
  }
}
