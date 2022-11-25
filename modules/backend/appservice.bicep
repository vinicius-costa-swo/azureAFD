resource frontDoorProfile 'Microsoft.Cdn/profiles@2021-06-01' existing = {
  name: 'appProfile'
} 

//app service plan

param appServicePlanName string
param applocation string
param appServiceSkuName string
param appServiceCapacity int

resource appServicePlan 'Microsoft.Web/serverFarms@2020-06-01' =  {
  name: appServicePlanName
  location: applocation
  sku: {
    name: appServiceSkuName
    capacity: appServiceCapacity
  }
  kind: 'app'
}

//app service app

param appName string
param AppServiceLocation string 

resource appServiceApp 'Microsoft.Web/sites@2022-03-01' = {
  name: appName
  location: AppServiceLocation
  kind: 'app'
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
