param frontDoorProfileName string
param location string

@allowed([
  'S1'
])
param frontDoorSkuName string
resource frontDoorProfile 'Microsoft.Cdn/profiles@2021-06-01' = {
  name: frontDoorProfileName
  location: location
  sku: {
    name: frontDoorSkuName
  }
}
