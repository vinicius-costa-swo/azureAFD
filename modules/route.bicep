resource frondDoorEndpoint 'Microsoft.Cdn/profiles/afdendpoints@2021-06-01' existing = {
  name: 'fdprofilename/fdedp'
}
//param parent object
param frontDoorRouteName string
param dependsOn object
param originId string


resource frontDoorRoute 'Microsoft.Cdn/profiles/afdEndpoints/routes@2021-06-01' = {
  name: frontDoorRouteName
  parent: frondDoorEndpoint
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
