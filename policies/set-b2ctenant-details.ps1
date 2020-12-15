$B2CTenantName = "nameofmytenant"                     # not nameofmytenant.onmicrosoft.com
$ProxyIdentityExperienceFrameworkAppId = "..."        # guid of the AppID for ProxyIdentityExperienceFramework
$IdentityExperienceFrameworkAppId = "..."             # guid of the AppID for IdentityExperienceFramework
$storagePath = "https://your-storage-account.blob.core.windows.net/your-container/"
$AppInsightInstrumentationKey = "..."                 # guid of the AppInsighs Instrumentation Key
$ServiceUrl = "https://your-app-name-that-must-be-unique.azurewebsites.net"

$PolicyPath = (get-location).Path
$files = get-childitem -path $PolicyPath -name -include *.xml | Where-Object {! $_.PSIsContainer }
foreach( $file in $files ) {
    $PolicyFile = (Join-Path -Path $PolicyPath -ChildPath $file)
    $PolicyData = Get-Content $PolicyFile

    $PolicyData = $PolicyData.Replace("yourtenant", $B2CTenantName)
    $PolicyData = $PolicyData.Replace("ProxyIdentityExperienceFrameworkAppId", $ProxyIdentityExperienceFrameworkAppId)
    $PolicyData = $PolicyData.Replace("IdentityExperienceFrameworkAppId", $IdentityExperienceFrameworkAppId)
    $PolicyData = $PolicyData.Replace("https://your-storage-account.blob.core.windows.net/your-container/", $storagePath)
    $PolicyData = $PolicyData.Replace("https://your-app-name-that-must-be-unique.azurewebsites.net", $ServiceUrl)
    $PolicyData = $PolicyData.Replace("AppInsightInstrumentationKey", $AppInsightInstrumentationKey)

    Set-Content -Path $PolicyFile -Value $PolicyData
}