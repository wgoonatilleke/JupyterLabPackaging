
param JupyterLabVnet string
param location string
param JupyterLabSubnet string

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2021-05-01' = {
  name: JupyterLabVnet
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.1.0.0/16'
      ]
    }
    subnets: [
      {
        name: JupyterLabSubnet
        properties: {
          addressPrefix: '10.1.0.0/24'
        }
      }
    ]
  }
}
