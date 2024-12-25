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

# Get outdated apps
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

# Attempt to update each app
if ($apps.Count -gt 0) {
    foreach ($app in $apps) {
        Write-Output "$($app) installed and out of date. Attempting to update..."
        try {
            choco upgrade $app -y
            Write-Output "$($app) successfully updated to latest version"
        } catch {
            $message = $_.Exception.Message
            Write-Output "Error updating $($app): $message"
        }
    }
} else {
    Write-Output "All apps up to date"
}
