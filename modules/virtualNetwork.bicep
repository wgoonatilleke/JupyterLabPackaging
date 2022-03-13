
param JupyterLabVnet string
param location string
param JupyterLabSubnet string
param AzureBastionSubnet string

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
      {
        name: AzureBastionSubnet
        properties: {
          addressPrefix: '10.1.1.0/24'
        }
      }
    ]
  }
}
