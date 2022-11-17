param frontEndEndpointName string 
param location string = resourceGroup().location

resource frontDoorProfile 'Microsoft.Cdn/profiles@2021-06-01' existing =  {
  name: 'fd-swo-dev-we-1'
}

resource frontDoorEndpoint 'Microsoft.Cdn/profiles/afdEndpoints@2021-06-01' = {
  name: frontEndEndpointName
  location: location
  parent: frontDoorProfile
  properties:{
    enabledState: 'Enabled'
  }
}

output endpointName string = frontDoorEndpoint.name
output endpointHostname string = frontDoorEndpoint.properties.hostName

