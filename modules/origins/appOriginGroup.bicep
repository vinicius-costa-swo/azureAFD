
resource frontDoorProfile 'Microsoft.Cdn/profiles@2021-06-01' existing =  {
  name: 'appProfile'
}

param frontDoorOriginGroupName string
param sampleSize int
param sampleRequired int
param probeRequestType string
param probeProtocol string
param probeIntevalInSeconds int

resource frontDoorOriginGroup 'Microsoft.Cdn/profiles/originGroups@2021-06-01' = {
 name: frontDoorOriginGroupName
 parent:frontDoorProfile
 properties: {
   loadBalancingSettings: {
     sampleSize: sampleSize
     successfulSamplesRequired: sampleRequired
   }
   healthProbeSettings: {
     probePath: '/'
     probeRequestType: probeRequestType
     probeProtocol: probeProtocol
     probeIntervalInSeconds: probeIntevalInSeconds
   }
 }
}

output originId string = frontDoorOriginGroup.id

