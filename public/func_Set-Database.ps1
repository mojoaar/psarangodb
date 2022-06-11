function Set-Database {
    <#
    .SYNOPSIS
        Set the database to work against
    .DESCRIPTION
        Set the database to work against
    .NOTES
        Name: Set-Database
        Author: Morten Johansen
        Version: 0.0.1
        DateCreated: 2022-June-11
        DateUpdated: XXXX-XXX-XX
    .PARAMETER Name
        Name of the database to work against
    .EXAMPLE
        Set-Database -Name 'testDB'
        Will set the global variable ArangoDBDatabase to testDB
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true,Position=0,HelpMessage='Enter name of the database to work against.')]
        [string]$Name
    )
    if(!(Test-Environment)) {
        $_
    }
    try {
        Set-Variable -Name ArangoDBDatabase -Scope Global -Value $Url
    }
    catch {
        Write-Host "Failed to set the global variables!" -ForegroundColor red
        Write-Host "Exception Message: $($_.Exception.Message)" -ForegroundColor Red
        break
    }
}