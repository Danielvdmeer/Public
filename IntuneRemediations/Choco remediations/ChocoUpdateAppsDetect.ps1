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

# Get updated apps
$OutdatedApps = choco outdated
$counter = 0
$apps = @()

foreach ($x in $OutdatedApps) {
    if ($counter -lt 4) {
        $counter += 1
        continue
    }
    if ($x.Trim() -eq "") {
        break
    }
    $apps += $x.Split('|')[0]
}

# If outdated apps are found, update
if ($apps.Count -gt 0) {
    Write-Output "Out of date choco packages found"
    Exit 1
} else {
    Write-Output "All choco packages are up to date"
    Exit 0
}