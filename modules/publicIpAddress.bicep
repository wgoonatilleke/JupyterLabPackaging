// https://docs.microsoft.com/en-us/azure/templates/microsoft.network/publicipaddresses?tabs=bicep
param JupyterLabBastionIP string
param location string

resource publicIP 'Microsoft.Network/publicIPAddresses@2021-05-01' = {
  name: JupyterLabBastionIP
  location: location
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}
