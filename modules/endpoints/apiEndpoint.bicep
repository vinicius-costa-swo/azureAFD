resource apiProfile 'Microsoft.Cdn/profiles@2021-06-01' existing = {
  name:'apiProfile'
}

param apiEndpointName string
param location string
param enabledState string

resource frontDoorEndpoint 'Microsoft.Cdn/profiles/afdEndpoints@2021-06-01' = {
name: apiEndpointName
parent: apiProfile
location: location
properties: {
  enabledState: enabledState
}

}
