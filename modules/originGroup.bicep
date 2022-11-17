//importing existing Front Door Profile
resource frontDoorProfile 'Microsoft.Cdn/profiles@2021-06-01' existing =  {
  name: 'fd-swo-dev-we-1'
}

@description('Request Type for the Health Probe')
@allowed([
  'GET'
  'HEAD'
])
param requestType string

@description('The probe path definition')
@allowed([
  '/'
])
param probePath string

@description('Protocol of probe status check')
@allowed([
  'Http'
  'Https'
])
param probeProtocol string

param frontDoorOriginGroupName string
param sampleSize int
param samplesRequired int
param probeInterval int


resource frontDoorOriginGroup 'Microsoft.Cdn/profiles/originGroups@2021-06-01' = {
  name: frontDoorOriginGroupName
  parent: frontDoorProfile
  properties: {
    loadBalancingSettings: {
      sampleSize: sampleSize
      successfulSamplesRequired: samplesRequired
    }
    healthProbeSettings: {
      probePath: probePath
      probeRequestType: requestType
      probeProtocol: probeProtocol
      probeIntervalInSeconds: probeInterval
    }
  }
}
