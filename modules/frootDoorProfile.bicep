@description('Name of the Front Door Profile')
param frontDoorProfileName string 

@description('The Front Door Sku Name')
@allowed([
  'Standard_AzureFrontDoor'
  'Premium_AzureFrontDoor'

])
param frontDoorSkuName string 

param location string 

resource frontDoorProfile 'Microsoft.Cdn/profiles@2021-06-01' = {
  name: frontDoorProfileName
  location: location
  sku: {
    name: frontDoorSkuName
}
}

output profileName string = frontDoorProfile.name
output profileSkuName string = frontDoorProfile.sku.name
