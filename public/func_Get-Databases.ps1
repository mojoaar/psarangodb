function Get-Databases {
    <#
    .SYNOPSIS
        Get's all databases that the user has access to
    .DESCRIPTION
        Get's all databases that the user has access to
    .NOTES
        Name: Get-Databases
        Author: Morten Johansen
        Version: 0.0.1
        DateCreated: 2022-June-11
        DateUpdated: XXXX-XXX-XX
    .EXAMPLE
        Get-Databases
        Will return the databases that the user has access to
    #>
    if(!(Test-Environment)) {
        $_
    }
    try {
        (Invoke-RestMethod -Uri $Global:ArangoDBURL":"$Global:ArangoDBPort/_api/database/user -Headers $Global:ArangoDBHeader).result
    }
    catch {
        Write-Host "There was an error in your web request!" -ForegroundColor red
        Write-Host "Exception Message: $($_.Exception.Message)" -ForegroundColor Red
        break
    }
}