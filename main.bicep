targetScope = 'resourceGroup'

//Profile

var location = 'global'

//Endpoint
var endPointDeploymentName = 'edpDeploy'
var enabledState = 'Enabled'
var frontDoorEndPointName = '/fdedp'

module endPoint 'modules/frontDoorEndpoint.bicep' = {
  name: endPointDeploymentName
  params: {
    enabledState: enabledState
    frontDoorEndpointName: frontDoorEndPointName
    location: location 
  }
}

var appDeployName = 'appOriginDeploy'
var appWeight = 800
var appPriotity = 1
var originName = 'appOrigin'

module appServiceOrigin 'modules/originBackend/appOrigin.bicep' =  {
  name: appDeployName
  params: {
    appPriority: appPriotity
    appWeight: appWeight
    frontDoorOriginName:originName 
  }
}


//Origin
var originDeployName = 'originDeploy'
var frontDoorOriginGroupName = 'OriginGroup'
var poolIntervalInSeconds = 100
var probeProtocol = 'Http'
var probeRequestType = 'GET'
var sampleRequired = 3
var sampleSize = 4

module origin 'modules/originBackend/OriginGroup.bicep' = {
  name: originDeployName
  params: {
    frontDoorOriginGroupName: frontDoorOriginGroupName
    probeIntevalInSeconds: poolIntervalInSeconds
    probeProtocol: probeProtocol
    probeRequestType: probeRequestType
    sampleRequired: sampleRequired
    sampleSize: sampleSize
  }
}

//Route
var routeDeployName = 'routeDeploy'
var routeName = 'routeFD'

module route 'modules/route.bicep' = {
  name: routeDeployName
  params: {
    frontDoorRouteName: routeName
    originId: origin.outputs.originId
    }
}
