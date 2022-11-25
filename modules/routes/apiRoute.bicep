
resource frondDoorEndpoint 'Microsoft.Cdn/profiles/afdendpoints@2021-06-01' existing = {
  name: 'apiProfile/apiedp'
}

resource frontDoorApiOrigin 'Microsoft.Cdn/profiles/originGroups/origins@2021-06-01' existing = {
  name: 'apiProfile/apiOriginGroup/apiOrigin'
}

//param parent object
param frontDoorRouteName string
param originId string


resource frontDoorRoute 'Microsoft.Cdn/profiles/afdEndpoints/routes@2021-06-01' = {
  name: frontDoorRouteName
  parent: frondDoorEndpoint
  dependsOn:[
    frontDoorApiOrigin
  ]
  properties: {
    originGroup: {
      id: originId
    }
    supportedProtocols: [
      'Http'
      'Https'
    ]
    patternsToMatch: [
      '/*'
    ]
    forwardingProtocol: 'HttpsOnly'
    linkToDefaultDomain: 'Enabled'
    httpsRedirect: 'Enabled'
  }
}
