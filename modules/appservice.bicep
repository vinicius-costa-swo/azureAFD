param location string = resourceGroup().location

resource frontDoorProfile 'Microsoft.Cdn/profiles@2021-06-01' existing =  {
  name: 'fd-swo-dev-we-1'
}

resource appServicePlan 'Microsoft.Web/serverFarms@2020-06-01' = {
  name: 'testapp'
  location: location
  sku: {
    name: 'S1'
    capacity: 1
  }
  kind: 'app'
}

resource app 'Microsoft.Web/sites@2020-06-01' = {
  name: 'testapp'
  location: location
  kind: 'app'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
    siteConfig: {
      detailedErrorLoggingEnabled: true
      httpLoggingEnabled: true
      requestTracingEnabled: true
      ftpsState: 'Disabled'
      minTlsVersion: '1.2'
      ipSecurityRestrictions: [
        {
          tag: 'ServiceTag'
          ipAddress: 'AzureFrontDoor.Backend'
          action: 'Allow'
          priority: 100
          headers: {
            'x-azure-fdid': [
              frontDoorProfile.properties.frontDoorId
            ]
          }
          name: 'Allow traffic from Front Door'
        }
      ]
    }
  }
}

output appServiceHostName string = app.properties.defaultHostName
