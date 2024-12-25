# Variables for the registry key, property name and value
$regkey = "HKLM:\SOFTWARE\policies\Microsoft\Windows NT\Terminal Services"
$name = "DisablePasswordSaving"
$value = 0  # Set the desired value for the property

# Check if the property exists and has the correct value, create or update it if necessary
if (!(Get-ItemProperty -Path $regkey -Name $name -ErrorAction SilentlyContinue)) {
    Write-Output "Property '$name' does not exist"
    Exit 1  # Exit with an error code if the property does not exist

# If the property exists but has a different value, update it
} elseif ((Get-ItemProperty -Path $regkey -Name $name).$name -ne $value) {
    Write-Output "Property '$name' exists but has a different value"
    Exit 1 # Exit with an error code if the property has a different value

    # If the property exists and has the correct value, no action is needed
} elseif ((Get-ItemProperty -Path $regkey -Name $name).$name -eq $value) {
    Write-Output "Property '$name' exists and has the correct value"
    Exit 0  # Exit with a success code if the property exists and has the correct value
}