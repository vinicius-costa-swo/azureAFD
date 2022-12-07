param appServiceLocation string = resourceGroup().location
param appLocation string = resourceGroup().location
var appName = 'testappvinicosta'
var appServiceSkuName = 'F1'
var appServicePlanName = 'testappvinicosta'
var appServiceCapacity = 2
var appServiceDeployName = 'appServiceDeploy'

module appService 'modules/backend/appservice.bicep' = {
  name: appServiceDeployName
  params: {
    applocation: appLocation
    appName: appName
    appServiceCapacity: appServiceCapacity
    AppServiceLocation: appServiceLocation
    appServicePlanName: appServicePlanName
    appServiceSkuName: appServiceSkuName
  }
}

