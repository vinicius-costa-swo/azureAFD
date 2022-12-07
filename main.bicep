targetScope = 'resourceGroup'

//Profile

var location = 'global'




//Endpoint
var endPointDeploymentName = 'edpDeploy'
var enabledState = 'Enabled'
var frontDoorEndPointName = '/fdedp'

module endPoint 'modules/endpoints/appEndpoint.bicep' = {
  name: endPointDeploymentName
  params: {
    enabledState: enabledState
    frontDoorEndpointName: frontDoorEndPointName
    location: location 
  }
}
//app Service


var appDeployName = 'appOriginDeploy'
var appWeight = 800
var appPriotity = 1
var originName = 'appOrigin'

module appServiceOrigin 'modules/origins/appOrigin.bicep' =  {
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

module origin 'modules/origins/appOriginGroup.bicep' = {
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

module route  'modules/routes/appRoute.bicep' = {
  name: routeDeployName
  params: {
    frontDoorRouteName: routeName
    originId: origin.outputs.originId
    }
}

//Deployment Frontdoor API Management Infra


var apiEndpointDeploymentName = 'apiEndpointDeploy'
var apiEnabledState = 'Enabled'
var apiEndPointName = 'apiedp'

module apiEndpoint 'modules/endpoints/apiEndpoint.bicep' = {
  name: apiEndpointDeploymentName
  params: {
    apiEndpointName: apiEndPointName
    enabledState: apiEnabledState
    location: location
  }
}
var apiOriginGrouDeployName = 'apiOriginGroupDeploy'
var apiOriginGroupName = 'apiOriginGroup'
var apiPoolIntervalInSeconds = 100
var apiProbeProtocol = 'Http'
var apiProbeRequestType = 'GET'
var apiSampleRequired = 3
var apiSampleSize = 4

module apiOriginGroup 'modules/origins/apiOriginGroup.bicep' = {
  name: apiOriginGrouDeployName
  params: {
    apiOriginGroupName: apiOriginGroupName
    apiprobeIntevalInSeconds: apiPoolIntervalInSeconds
    apiprobeProtocol: apiProbeProtocol
    apiprobeRequestType: apiProbeRequestType
    apisampleRequired: apiSampleRequired
    apisampleSize: apiSampleSize
  }
}

var apiOriginName = 'apiOrigin'
var apiWeight = 1000
var apiPriority = 2
var apiOriginDeployName = 'apiOriginDeploy'

module apiOrigin 'modules/origins/apiOrigin.bicep' =  {
  name: apiOriginDeployName
  params: {
    appPriority: apiPriority
    appWeight: apiWeight
    frontDoorOriginName: apiOriginName
  }
}


var apiRouteDeployName = 'apiRouteDeploy'
var apiRouteName = 'apiRoute'

module apiRoute 'modules/routes/apiRoute.bicep' = {
  name: apiRouteDeployName
  params: {
    frontDoorRouteName: apiRouteName
    originId:apiOriginGroup.outputs.originId
}
}
