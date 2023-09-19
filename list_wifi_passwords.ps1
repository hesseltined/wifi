# Get the list of Wi-Fi profiles
$wifiProfiles = netsh wlan show profiles | Select-String "All User Profile" | ForEach-Object { $_ -replace "All User Profile\s+:\s+" }

 

# Loop through each profile and retrieve the password
foreach ($profile in $wifiProfiles) {
    $profileName = $profile.Trim()
    $wifiInfo = netsh wlan show profile name="$profileName" key=clear
    $password = $wifiInfo | Select-String "Key Content\s+:\s+" | ForEach-Object { $_ -replace "Key Content\s+:\s+" }

    Write-Host "Wi-Fi Profile: $profileName"
    Write-Host "Password: $password"
    Write-Host ""
}
