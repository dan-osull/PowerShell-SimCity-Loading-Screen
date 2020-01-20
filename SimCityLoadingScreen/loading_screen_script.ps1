# Script that displays Sim City loading screen messages with random colours
# It will normally be called by function Show-SimCityLoadingScreen in module file SimCityLoadingScreen.psm1

param (
    $WindowTitle    = 'Loading...',
    $WindowWidth    = 50,
    $WindowHeight   = 30,
    $WelcomeMessage = 'Loading. Please wait...'
)

# Configure window
[System.Console]::Title        = $WindowTitle
[System.Console]::WindowWidth  = $WindowWidth
[System.Console]::WindowHeight = $WindowHeight

# Write welcome message to console
$WelcomeMessage
''

$colours = [System.Enum]::GetValues('ConsoleColor')

Get-Content (Join-Path $PSScriptRoot 'loading_messages.txt') | 
    # Randomise order of messages
    Sort-Object {Get-Random} | 
    # Loop through messages
    ForEach-Object {
        # Display message with random foreground and background
        Write-Host $_ -ForegroundColor ($colours | Get-Random) -BackgroundColor ($colours | Get-Random)
        # Wait a random amount of time
        Start-Sleep -Milliseconds (Get-Random -Minimum 0 -Maximum 1500)
    }