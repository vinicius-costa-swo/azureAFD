resource frontDoorOriginGroup 'Microsoft.Cdn/profiles/originGroups@2021-06-01' existing = {
   name:'appProfile/OriginGroup'
}

resource appService 'Microsoft.Web/sites@2022-03-01' existing = {
  name: 'testappvinicosta'
}


param frontDoorOriginName string
param appPriority int
param appWeight int
//param appHostname string
//param appHostHeader string


resource frontDoorAppOrigin 'Microsoft.Cdn/profiles/originGroups/origins@2021-06-01' =  {
  name: frontDoorOriginName
  parent: frontDoorOriginGroup
  properties: {
    hostName: appService.properties.defaultHostName
    httpPort: 80
    httpsPort: 443
    originHostHeader: appService.properties.defaultHostName
    priority: appPriority
    weight: appWeight
 
  }
 }


output originHostname string = appService.properties.defaultHostName
output origin string = frontDoorAppOrigin.id
