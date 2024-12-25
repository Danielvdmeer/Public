# Variables for the registry key, property name and value
$regkey = "HKLM:\SOFTWARE\policies\Microsoft\Windows NT\Terminal Services"
$name = "DisablePasswordSaving"
$value = 0  # Set the desired value for the property

# Check if the property exists and has the correct value, create or update it if necessary
if (!(Get-ItemProperty -Path $regkey -Name $name -ErrorAction SilentlyContinue)) {
    Set-ItemProperty -Path $regkey -Name $name -Value $value
    Write-Output "Property '$name' created with value: $value"

# If the property exists but has a different value, update it
} elseif ((Get-ItemProperty -Path $regkey -Name $name).$name -ne $value) {
    Set-ItemProperty -Path $regkey -Name $name -Value $value
    Write-Output "Property '$name' updated with value: $value"
}