Function Show-SimCityLoadingScreen {
    <#
    .SYNOPSIS
        Create a new PowerShell window that scrolls through classic Sim City loading messages
    .DESCRIPTION
        This function is a wrapper for loading_screen_script.ps1
    .EXAMPLE
        # Create loading screen
        $loadingScreen = Show-SimCityLoadingScreen

        'Doing something...'
        Start-Sleep -Seconds 10
        'Done'

        # Close loading screen
        $loadingScreen.Kill()
    .EXAMPLE
        Show-SimCityLoadingScreen -WindowTitle 'Custom title' -WelcomeMessage 'Custom welcome message' -WindowHeight 20 -WindowWidth 80
    .OUTPUTS
        System.Diagnostics.Process
    .LINK
        https://github.com/weebsnore/PowerShell-SimCity-Loading-Screen
    #>
    param (
        [string]$WindowTitle,
        [int]$WindowHeight,
        [int]$WindowWidth,
        [string]$WelcomeMessage
    )

    # Decide whether to spawn pwsh or powershell
    $powerShellPath = if ($PSVersionTable.PSEdition -eq 'Core') {'pwsh'} else {'powershell'}

    # Construct PowerShell arguments
    $loadingScreenPath = Join-Path $PSScriptRoot 'loading_screen_script.ps1'
    $psArguments = @()
    $psArguments += '-ExecutionPolicy Bypass'
    $psArguments += "-File `"$loadingScreenPath`""
    if ($WindowTitle)    {$psArguments += "-WindowTitle `"$WindowTitle`""}
    if ($WindowHeight)   {$psArguments += "-WindowHeight $WindowHeight"}
    if ($WindowWidth)    {$psArguments += "-WindowWidth $WindowWidth"}
    if ($WelcomeMessage) {$psArguments += "-WelcomeMessage `"$WelcomeMessage`""}

    # Launch loading screen script and return process object
    # The process object can later be killed to close the window
    return Start-Process -FilePath $powerShellPath -PassThru -ArgumentList $psArguments
}