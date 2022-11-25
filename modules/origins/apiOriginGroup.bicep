
resource apiProfile 'Microsoft.Cdn/profiles@2021-06-01' existing = {
  name:'apiProfile'
}

param apiOriginGroupName string
param apisampleSize int
param apisampleRequired int
param apiprobeRequestType string
param apiprobeProtocol string
param apiprobeIntevalInSeconds int

resource frontDoorOriginGroup 'Microsoft.Cdn/profiles/originGroups@2021-06-01' = {
 name: apiOriginGroupName
 parent:apiProfile
 properties: {
   loadBalancingSettings: {
     sampleSize: apisampleSize
     successfulSamplesRequired: apisampleRequired
   }
   healthProbeSettings: {
     probePath: '/'
     probeRequestType: apiprobeRequestType
     probeProtocol: apiprobeProtocol
     probeIntervalInSeconds: apiprobeIntevalInSeconds
   }
 }
}

output originId string = frontDoorOriginGroup.id

