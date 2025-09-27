# Define variables
$startupFolder = "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Startup"
$shortcutName = "Microsoft Edge AutoOpen.lnk"
$shortcutPath = "$startupFolder\$shortcutName"
$edgeExePath = "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"  # Adjust if needed
$targetUrl = "https://www.intuneinsights.org/"  # Updated URL from input

# Check if the shortcut already exists
if (Test-Path $shortcutPath) {
    Write-Output "Shortcut already exists in Startup folder."
    exit 0
}

# Verify Edge executable exists
if (-not (Test-Path $edgeExePath)) {
    Write-Output "Microsoft Edge not found at $edgeExePath."
    exit 1
}

# Create the shortcut
$shell = New-Object -ComObject WScript.Shell
$shortcut = $shell.CreateShortcut($shortcutPath)
$shortcut.TargetPath = $edgeExePath
$shortcut.Arguments = "--start-maximized $targetUrl"  # Opens Edge maximized with the URL
$shortcut.IconLocation = "$edgeExePath,0"  # Use Edge's default icon
$shortcut.Description = "Microsoft Edge with Intune Insights URL"
$shortcut.Save()

Write-Output "Created Edge shortcut with URL in Startup folder."
