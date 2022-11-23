resource frontDoorProfile 'Microsoft.Cdn/profiles@2021-06-01' existing = {
  name: 'fdprofilename'
}

var appName = 'testappvinicosta'
var appServiceSkuName = 'F1'
var kind = 'app'
var appServicePlanName = 'appServiceFD'
var appServiceCapacity = 1
param AppServiceLocation string = resourceGroup().location



resource appServicePlan 'Microsoft.Web/serverFarms@2020-06-01' =  {
  name: appServicePlanName
  location: AppServiceLocation
  sku: {
    name: appServiceSkuName
    capacity: appServiceCapacity
  }
  kind: 'app'
}

//appService Deploy

resource appServiceApp 'Microsoft.Web/sites@2022-03-01' = {
  name: appName
  location: AppServiceLocation
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
            frontDoorProfile.properties.frontDoorId
          ]
        }
        name: 'Allow traffic from Front Door'
      }]
    }
  }
}

output hostName string = appServiceApp.properties.defaultHostName
