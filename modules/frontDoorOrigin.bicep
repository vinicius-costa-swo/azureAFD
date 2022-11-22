resource frontDoorProfile 'Microsoft.Cdn/profiles@2021-06-01' existing =  {
   name: 'fdprofilename'
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

param frontDoorOriginName string
param priority int
param weight int
param hostname string
param originHostHeader string

resource frontDoorOrigin 'Microsoft.Cdn/profiles/originGroups/origins@2021-06-01' = {
  name: frontDoorOriginName
  parent: frontDoorOriginGroup
  properties: {
    hostName: hostname
    httpPort: 80
    httpsPort: 443
    originHostHeader: originHostHeader
    priority: priority
    weight: weight

  }
}

output originId string = frontDoorOriginGroup.id
output fdorigin object = frontDoorOrigin
