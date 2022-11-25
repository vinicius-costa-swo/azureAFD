param apiManagementServiceName string
param location string
param sku string
param skuCount int
param publisherEmail string
param publisherName string


resource apiManagementService 'Microsoft.ApiManagement/service@2021-08-01'  = {
  name: apiManagementServiceName
  location: location
  sku: {
    name: sku
    capacity: skuCount
  }
  properties: {
    publisherEmail: publisherEmail
    publisherName: publisherName
  }
}

output apiMgmtHost string = apiManagementService.properties.managementApiUrl
