resource frontDoorOriginGroup 'Microsoft.Cdn/profiles/originGroups@2021-06-01' existing = {
  name:'fdprofilename/OriginGroup'
}


param frontDoorOriginName string
param appPriority int
param appWeight int
param appHostname string = 'apim-gnt-dev-1-weu.azure-api.net'


resource frontDoorAppOrigin 'Microsoft.Cdn/profiles/originGroups/origins@2021-06-01' =  {
 name: frontDoorOriginName
 parent: frontDoorOriginGroup
 properties: {
   hostName: appHostname
   httpPort: 80
   httpsPort: 443
   originHostHeader: appHostname
   priority: appPriority
   weight: appWeight

 }
}


output origin string = frontDoorAppOrigin.id
