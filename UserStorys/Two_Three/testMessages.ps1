$iotHubName = "<IoT Hub Name>"
$storageAccountName = "< Storage Account Name>"
$containerName = "<Container Name>"

$deviceId = "<Testing Device>"
$message = ".\UserStorys\Two_Three\message.json"
$destinationPath = ".\UserStorys\Two_Three\resultBlob.json"

Write-Host "Sending Message"
az iot device send-d2c-message -n $iotHubName -d $deviceId --props '$.ct=application/json;$.ce=utf-8' --data-file-path $message
Write-Output "Message sent successfully."

Clear-Content -Path $destinationPath

Write-Host "Please Wait for Azure... this can take up to three minutes."
$DateTime = Get-Date
$utcTime = $DateTime.ToUniversalTime()
$year = $utcTime.Year.ToString("0000")
$month = $utcTime.Month.ToString("00")
$day = $utcTime.Day.ToString("00")
$hour = $utcTime.Hour.ToString("00")
$minute = $utcTime.Minute.ToString("00")
 
$utcString = "$year/$month/$day/$hour/$minute"
$filepath = "$iotHubName/02/$utcString.JSON"

Start-Sleep -Seconds 150

Write-Host $filePath

Write-Host "Downloading Blob"
az storage blob download --account-name $storageAccountName -c $containerName --name $filePath --file $destinationPath 
Write-Host "Blob download successfully"

$string = Get-Content -Path $destinationPath -Raw 

if ($string -eq "" -or $null -eq $string){
    Write-Output "Test Unsuccessfull"
}
else {
    if ($string.Contains("This is a testing Message")) {
        Write-Output "Test Successfull"
    } else {
        Write-Output "Test Unsuccessfull"
    }
}