resource app 'Microsoft.Web/sites@2020-06-01' existing =  {
  name: 'testapp'
}

resource frontDoorOriginGroup 'Microsoft.Cdn/profiles/originGroups@2021-06-01' existing = {
  name: '/originGroup'
}

param frontDoorOriginName string
param priority int
param weight int

resource frontDoorOrigin 'Microsoft.Cdn/profiles/originGroups/origins@2021-06-01' = {
  name: frontDoorOriginName
  parent: frontDoorOriginGroup
  properties: {
    hostName: app.properties.defaultHostName
    httpPort: 80
    httpsPort: 443
    originHostHeader: app.properties.defaultHostName
    priority: priority
    weight: weight
  }
}
