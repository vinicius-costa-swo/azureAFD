param frontDoorProfileName string
param location string = 'global'

@allowed([
  'Standard_AzureFrontDoor'
])
param frontDoorSkuName string


@description('Front Door Profile Creation')
resource frontDoorProfile 'Microsoft.Cdn/profiles@2021-06-01' =  {
  name: frontDoorProfileName
  location: location
  sku: {
    name: frontDoorSkuName
  }
}

output profileId string = frontDoorProfile.properties.frontDoorId


