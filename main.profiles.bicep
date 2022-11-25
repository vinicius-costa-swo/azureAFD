var apiProfileName = 'apiProfile'
var apiProfileDeployName = 'apiProfileDeploy'
var apiLocation = 'global'
var apiDoorSkuName = 'Standard_AzureFrontDoor'


module apiProfile 'modules/profiles/apiProfile.bicep' = {
  name: apiProfileDeployName
  params: {
    apiProfileName: apiProfileName
    frontDoorSkuName:apiDoorSkuName
    location: apiLocation
  }
}

var appProfileName = 'appProfile'
var appProfileDeployName = 'appProfileDeploy'
var appSkuName = 'Standard_AzureFrontDoor'
var appLocation = 'global'


module appProfile 'modules/profiles/appProfile.bicep' = {
  name: appProfileDeployName
  params: {
    appProfileName: appProfileName
    frontDoorSkuName: appSkuName
    location: appLocation
  }
}
