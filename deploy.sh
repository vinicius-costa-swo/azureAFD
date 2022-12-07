nt group creataz deployment group create --resource-group rg-vinicius-costa-demo --template-file main.profiles.bicep

az deploymee --resource-group rg-vinicius-costa-demo --template-file main.backend.bicep

az deployment group create --resource-group rg-vinicius-costa-demo --template-file main.bicep
