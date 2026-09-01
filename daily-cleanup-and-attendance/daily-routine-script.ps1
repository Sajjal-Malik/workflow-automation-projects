param(
    [Parameter(Mandatory = $true)]
    # [ValidateSet("cleanup", "startup", ErrorMessage = "Invalid option! Please type either 'cleanup' or 'startup'.")] #Modern Way of Validating Arguments
    [string]$Option
)

# The Universal Way -Manual Validation)
if ($Option -ne "cleanup" -and $Option -ne "startup") {
    Write-Host "=============================================" -ForegroundColor Red
    Write-Host " ERROR: Invalid option '$Option' provided!" -ForegroundColor Red
    Write-Host " Please use only: 'cleanup' or 'startup'" -ForegroundColor Yellow
    Write-Host "=============================================" -ForegroundColor Red
    # Start-Sleep -Seconds 1
    exit
}

# Check if running as Admin
$id = [System.Security.Principal.WindowsPrincipal][System.Security.Principal.WindowsIdentity]::GetCurrent()
$isAdmin = ($id).IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin) {
    Write-Host "Requesting administrative privileges..." -ForegroundColor Blue

    # Relaunch the script with Administrator privileges (User Account Control -> UAC pop-up will open)
    Start-Process powershell -ArgumentList "-ExecutionPolicy Bypass -File `"$PSCommandPath`" -Option `"$Option`"" -Verb RunAs

    Write-Host "Script execution complete successfully!" -ForegroundColor Yellow

    # Exit the current non-admin process
    exit
}

# --- Everything below this line runs ONLY in the Administrator window ---

if ($Option -eq "cleanup") { 
    Write-Host "Starting daily workplace routine..." -ForegroundColor Green

    # Run the Python cleanup script
    python "path\of\python_script.py" OR "specify execution of any other script"
}

if ($Option -eq "startup") { 
    Write-Host "Starting daily workplace routine..." -ForegroundColor Green

    # Run the Python cleanup script
    python "path\of\python_script.py" OR "specify execution of any other script"

    # Launch daily workplace applications
    Write-Host "Launching workplace applications (De-elevated to Standard User)..." -ForegroundColor Cyan

    # Starting this App with Admin privileges
    Start-Process "chrome.exe"

    # "explorer.exe" -ArgumentList" -> This makes Applications Run as Standard User 
    Start-Process "explorer.exe" -ArgumentList "name of an application" OR "path\of\other\application"

    Write-Host "Routine complete. Closing in 5 seconds..." -ForegroundColor Green

    # Give applications time to detach completely
    Start-Sleep -Seconds 5
}
