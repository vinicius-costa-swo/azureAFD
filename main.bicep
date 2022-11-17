//Setting The deployment Scope
targetScope = 'subscription'

//Deployment Variables for Front Door Profile
var profileDeploymentName = 'afdProfileDepolyment'
var frontDoorProfileName = 'fd-swo-dev-we-1'
var frontDoorSkuName = 'Premium_AzureFrontDoor'
var location = 'global'
var resourceGroupName = 'rg-vinicius-costa-demo'

// Front door Profile

@description('Importing module to deploy Azure Froont Door')
module frontDoorProfile 'modules/frootDoorProfile.bicep' = {
  scope: resourceGroup(resourceGroupName)
  name: profileDeploymentName
  params: {
    frontDoorProfileName: frontDoorProfileName
    frontDoorSkuName: frontDoorSkuName
    location: location
  }
}

//Deployment Variables to Front Door Endpoint

var endpointDeploymentName = 'afdEndpointDepolyment'
var EndEndpointName = 'fd-swo-dev-we-1'

//Front Door Endpoint deployment

@description('Importing module to deploy Front Door Endpoint')
module frontDoorEndpoint  'modules/frontDoorEndpoint.bicep' = {
  scope: resourceGroup(resourceGroupName)
  name: endpointDeploymentName
  params: {
    frontEndEndpointName: EndEndpointName
    location: location
  }
}

//Variables for Front Door Origin Group
var originGroupDeploymentName = 'afdOriginGroupDeploy'
var originGroupName = 'originGroup'
var probeInterval = 100
var probePath = '/'
var probeProtocol = 'Https'
var requestType = 'GET'
var sampleSize = 4
var samplesRequired = 3

//Front Door Origin Group
@description('Importing module to deploy Front Door Origin Group')
module frontDoorOriginGroup 'modules/originGroup.bicep' = {
  scope: resourceGroup(resourceGroupName)
  name: originGroupDeploymentName
  params: {
    frontDoorOriginGroupName: originGroupName
    probeInterval: probeInterval
    probePath: probePath
    probeProtocol: probeProtocol
    requestType: requestType
    sampleSize: sampleSize
    samplesRequired: samplesRequired
  }
}

//variables for front door origin
var priotity = 1
var weight = 1000
var frontDoorOriginName = 'testOrigin'
var originDeployname = 'originDeploy'

//Front Door Origin
@description('Import module Front Door Origin')
module Origin 'modules/frontDoorOrigin.bicep' = {
  scope: resourceGroup(resourceGroupName)
  name: originDeployname
  params: {
    frontDoorOriginName: frontDoorOriginName
    priority: priotity
    weight: weight
  }
}

//Front Door Route

module route 'modules/route.bicep' = {
  scope: resourceGroup(resourceGroupName)
  name: 'testdeploy'
  params: {
    frontDoorRouteName: 'frontdoorRoute'
  }
}
