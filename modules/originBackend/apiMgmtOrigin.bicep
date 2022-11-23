
resource frontDoorOriginGroup 'Microsoft.Cdn/profiles/originGroups@2021-06-01' existing = {
  name: 'OriginGroup/'
}

param apiOriginName string
param apiMgmtHostName string
param apiMgmtHostHeader string
param apiMgmtPriority int
param apiMgmtWeight int

resource frontDoorAppOrigin 'Microsoft.Cdn/profiles/originGroups/origins@2021-06-01' = {
  name: apiOriginName
  parent: frontDoorOriginGroup
  properties: {
    hostName: apiMgmtHostName
    httpPort: 80
    httpsPort: 443
    originHostHeader: apiMgmtHostHeader
    priority: apiMgmtPriority
    weight: apiMgmtWeight
 
  }
 }

