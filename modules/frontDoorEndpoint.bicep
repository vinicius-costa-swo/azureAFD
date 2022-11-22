resource frontDoorProfile 'Microsoft.Cdn/profiles@2021-06-01' existing =  {
    name: 'fdprofilename'
}

param frontDoorEndpointName string
param location string
param enabledState string

resource frontDoorEndpoint 'Microsoft.Cdn/profiles/afdEndpoints@2021-06-01' = {
  name: frontDoorEndpointName
  parent: frontDoorProfile
  location: location
  properties: {
    enabledState: enabledState
  }
}

output endpointURL string = frontDoorEndpoint.properties.hostName
