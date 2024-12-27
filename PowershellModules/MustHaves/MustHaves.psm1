# Function to check if Chocolatey is installed and install if needed
function Install-Chocolatey {
    # Check for Chocolatey
$choco = "C:\ProgramData\chocolatey"
Write-Output "Checking if Chocolatey is installed on $(Env:COMPUTERNAME)..."
if (!(Test-Path $choco)) {
    Write-Output "Chocolatey not found, installing now..."
    try {
        Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
        Write-Output "Successfully installed Chocolatey"
    } catch {
        $message = $_.Exception.Message
        Write-Output "Error installing Chocolatey: $message"
    }
} else {
    Write-Output "Chocolatey is installed"
}
}

# Function for logging
function log-message {
    param (
        [string]$message,
        
        [parameter (Mandatory, helpMessage = "Please provide the log file name")]
        [string]$logFile
    )
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logPath = "C:\Logs\$logFile"
    
    # Check if the directory exists, create if not
    if (!(Test-Path C:\Logs)) {
        New-Item -Path C:\logs -ItemType Directory
    }
    
    # Add the log message to the log file
    Add-Content -Path $logPath -Value "$timestamp - $message"
    Write-Host $message
}