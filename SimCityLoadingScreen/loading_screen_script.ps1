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

# Get messages and randomise
$messages = Get-Content (Join-Path $PSScriptRoot 'loading_messages.txt') | Sort-Object {Get-Random}

# Loop through messages
$colours = [System.Enum]::GetValues('ConsoleColor')
foreach ($message in $messages) {
    # Pad message to width of window
    $windowWidth = $host.UI.RawUI.WindowSize.Width
    $message = $message.PadRight($windowWidth)
    # Display message with random foreground and background
    Write-Host $message -ForegroundColor ($colours | Get-Random) -BackgroundColor ($colours | Get-Random)
    # Wait a random amount of time
    Start-Sleep -Milliseconds (Get-Random -Minimum 0 -Maximum 1500)
}