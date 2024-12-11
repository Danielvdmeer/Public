# Creates the parameter 'Action' for either Install or Uninstall
# !IMPORTANT! - The 'Param' cmdlet must be the first actual code in the script for it to work, if you change the position it stops working.
param (
    [Parameter(Mandatory, HelpMessage = "Please choose either Install or Uninstall as 'Action' parameter")]
    [ValidateSet("Install", "Uninstall")]
    [String]$Action,

    [Parameter(Mandatory, HelpMessage = "Please provide the Chocolatey package name")]
    [String]$ChocoPackage
)

# Set variables
$localprograms = choco list --localonly

# If parameter action equals 'Install' then check if program exists, update if it does exist and install if its not present
try {
    if ($Action -eq "Install") {
        if ($localprograms -like "*$ChocoPackage*") {
            Write-Output "Upgrading $ChocoPackage..."
            choco upgrade $ChocoPackage -y
        } else {
            Write-Output "Installing $ChocoPackage..."
            choco install $ChocoPackage -y --force
        }
    } elseif ($Action -eq "Uninstall") {
        Write-Output "Uninstalling $ChocoPackage..."
        choco uninstall $ChocoPackage -y
    }

# Else if parameter Action isn't either option, write error.
    else {
    Write-Output "Invalid action. Please specify 'Install' or 'Uninstall'."
}

} catch {
    Write-Error "An error occurred: $_"
}