az deployment group create --resource-group rg-vinicius-costa-demo --template-file main.profiles.bicep

az deployment group create --resource-group rg-vinicius-costa-demo --template-file main.backend.bicep

az deployment group create --resource-group rg-vinicius-costa-demo --template-file main.bicep
