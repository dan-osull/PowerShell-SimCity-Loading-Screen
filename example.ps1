Import-Module .\SimCityLoadingScreen

# Create loading screen
$loadingScreen = Show-SimCityLoadingScreen

'Doing something...'
Start-Sleep -Seconds 10
'Done'

# Close loading screen
$loadingScreen.Kill()