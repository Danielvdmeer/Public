$GroupName = "Fill in the desired groupname"
$GPOs = Get-GPO -All
foreach ($GPO in $GPOs) {
    $GPOReport = Get-GPOReport -Guid $GPO.Id -ReportType XML
    if ($GPOReport -like "*$GroupName*") {
        Write-Output "Group $GroupName is used in GPO: $($GPO.DisplayName)"
    }
}