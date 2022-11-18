
param appServicePlanName string
param location string
@allowed([
  'F1'
])
param appServicePlanSkuName string
param appServicePlanCapacity int

resource appServicePlan 'Microsoft.Web/serverFarms@2020-06-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: appServicePlanSkuName
    capacity: appServicePlanCapacity
  }
  kind: 'app'
}

//appService Deploy

param kind string
param appName string
param frontDoorId string

resource appServiceApp 'Microsoft.Web/sites@2022-03-01' = {
  name: appName
  location: location
  kind: kind
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
    siteConfig:{
      detailedErrorLoggingEnabled: true
      httpLoggingEnabled: true
      requestTracingEnabled: true
      ftpsState: 'Disabled'
      minTlsVersion: '1.2'
      ipSecurityRestrictions:[{
        tag: 'ServiceTag'
        ipAddress: 'AzureFrontDoor.Backend'
        action: 'Allow'
        priority: 100
        headers: {
          'x-azure-fdid':[
            frontDoorId
          ]
        }
        name: 'Allow traffic from Front Door'
      }]
    }
  }
}

output hostName string = appServiceApp.properties.defaultHostName
