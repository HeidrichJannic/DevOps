param (
    [string]$environment
)
 
function DeployToDev {
    Write-Host "Deploying to Dev environment..."
    az deployment group create --resource "<Resource-Group-Name>" --template-file .\DevOps\UserStorys\One\userStoryOne.bicep --parameters .\DevOps\UserStorys\One\parameters.dev.json --confirm-with-what-if
}
 
function DeployToTest {
    Write-Host "Deploying to Test environment..."
    az deployment group create --resource "<Resource-Group-Name>" --template-file .\DevOps\UserStorys\One\userStoryOne.bicep --parameters .\DevOps\UserStorys\One\parameters.test.json --confirm-with-what-if
}
 
function DeployToProd {
    Write-Host "Deploying to Prod environment..."
    az deployment group create --resource "<Resource-Group-Name>" --template-file .\DevOps\UserStorys\One\userStoryOne.bicep --parameters .\DevOps\UserStorys\One\parameters.prod.json --confirm-with-what-if
}
 
# Main script logic
if ($environment -eq 'dev') {
    DeployToDev
}
elseif ($environment -eq 'test') {
    DeployToTest
}
elseif ($environment -eq 'prod') {
    DeployToProd
}
else {
    Write-Host "Invalid environment parameter. Please use 'dev', 'test', or 'main'."
}