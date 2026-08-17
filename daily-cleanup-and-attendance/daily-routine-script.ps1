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
python "D:\Learn and Work\Secure Programming\workflow-automation-projects\daily-cleanup-and-attendance\clean_up.py"

Write-Host "Launching workplace applications..."

# Launch daily workplace applications
Start-Process "chrome.exe"
Start-Process "slack.exe"
Start-Process "C:\Users\Sajal\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Time Doctor.lnk"

Write-Host "Routine complete. Closing in 10 seconds..." -ForegroundColor Green

# Give applications time to detach completely
Start-Sleep -Seconds 10