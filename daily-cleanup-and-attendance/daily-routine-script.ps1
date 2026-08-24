# Check if running as Admin
$id = [System.Security.Principal.WindowsPrincipal][System.Security.Principal.WindowsIdentity]::GetCurrent()
$isAdmin = ($id).IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin) {
    Write-Host "Requesting administrative privileges..." -ForegroundColor Yellow

    # Relaunch the script with Administrator privileges (User Account Control -> UAC pop-up will open)
    Start-Process powershell -ArgumentList "-ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs

    # Exit the current non-admin process
    exit
}

Write-Host "Starting daily workplace routine..." -ForegroundColor Green

# Run the Python cleanup script
python "path\of\python_script.py" OR "specify execution of any other script"

Write-Host "Launching workplace applications..."

# Launch daily workplace applications
Start-Process "chrome.exe"
Start-Process "slack.exe"
Start-Process "name of an application" OR "path\of\other\application"

Write-Host "Routine complete. Closing in 10 seconds..." -ForegroundColor Green

# Give applications time to detach completely
Start-Sleep -Seconds 5
