# Check if running as Admin
$isAdmin = ([System.Security.Principal.WindowsPrincipal][System.Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin) {
    Write-Host "Requesting administrative privileges..." -ForegroundColor Yellow

    # Relaunch the script with Administrator privileges
    Start-Process powershell -ArgumentList "-ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs

    # Exit the current non-admin process
    exit 
}

Write-Host "Starting daily workplace routine..." -ForegroundColor Green

# Run the Python cleanup script
python "path\of\python_script.py"

Write-Host "Launching workplace applications..."

# Launch daily workplace applications
Start-Process "chrome.exe"
Start-Process "slack.exe"
Start-Process "name" or "path\of\other\applications"

Write-Host "Routine complete. Closing in 10 seconds..." -ForegroundColor Green

# Give applications time to detach completely
Start-Sleep -Seconds 10