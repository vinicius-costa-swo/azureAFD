targetScope = 'resourceGroup'

//Profile
var frontDoorProfileName = 'fdprofilename'
var profileDeployName = 'profileDeploy'
var frontDoorSkuName = 'S1'
var location = 'global'


module frontDoorProfile 'modules/frootDoorProfile.bicep' = {
  name: profileDeployName
  params: {
    frontDoorProfileName: frontDoorProfileName
    frontDoorSkuName: frontDoorSkuName
    location: location
  }
}

//AppService
var appServiceDeployName = 'AppServiceDeploy'
var appName = 'testapp'
var appServiceSkuName = 'F1'
var kind = 'app'
var appServicePlanName = 'appServiceFD'
var appServiceCapacity = 1

module appService 'modules/appservice.bicep' = {
  name: appServiceDeployName
  params: {
    appName: appName
    appServicePlanCapacity: appServiceCapacity
    appServicePlanName: appServicePlanName
    appServicePlanSkuName: appServiceSkuName
    kind: kind
    location: location
    frontDoorId:frontDoorProfile.outputs.profileId
  }
}

//Endpoint
var endPointDeploymentName = 'edpDeploy'
var enabledState = 'Enabled'
var frontDoorEndPointName = 'fdedp'

module endPoint 'modules/frontDoorEndpoint.bicep' = {
  name: endPointDeploymentName
  params: {
    enabledState: enabledState
    frontDoorEndpointName: frontDoorEndPointName
    location: location
    parent: frontDoorProfile
  }
}

//Origin
var originDeployName = 'originDeploy'
var frontDoorOriginGroupName = 'OriginGroup'
var frontDoorOriginName = 'OriginName'
var priority = 1
var poolIntervalInSeconds = 100
var probeProtocol = 'Http'
var probeRequestType = 'GET'
var sampleRequired = 3
var sampleSize = 4
var weight = 1000

module origin 'modules/frontDoorOrigin.bicep' = {
  name: originDeployName
  params: {
    frontDoorOriginGroupName: frontDoorOriginGroupName
    frontDoorOriginName: frontDoorOriginName
    priority: priority
    probeIntevalInSeconds: poolIntervalInSeconds
    probeProtocol: probeProtocol
    probeRequestType: probeRequestType
    sampleRequired: sampleRequired
    sampleSize: sampleSize
    weight: weight
    parent: frontDoorProfile
    hostname: appService.outputs.hostName
    originHostHeader: appService.outputs.hostName
  }
}

//Route
var routeDeployName = 'routeDeploy'
var routeName = 'routeFD'

module route 'modules/route.bicep' = {
  name: routeDeployName
  params: {
    dependsOn:origin.outputs.fdorigin
    frontDoorRouteName: routeName
    originId: origin.outputs.originId
    parent: endPoint   
  }
}
