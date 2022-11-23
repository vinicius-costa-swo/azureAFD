var frontDoorProfileName = 'fdprofilename'
var profileDeployName = 'profileDeploy'
var frontDoorSkuName = 'Standard_AzureFrontDoor'
var location = 'global'

module frontDoorProfile 'modules/frootDoorProfile.bicep' = {
  name: profileDeployName
  params: {
    frontDoorProfileName: frontDoorProfileName
    frontDoorSkuName: frontDoorSkuName
    location: location
  }
}
