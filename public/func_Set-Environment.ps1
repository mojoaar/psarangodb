function Set-Environment {
    <#
    .SYNOPSIS
        Set's the ArangoDBToken, ArangoDBHeader and ArangoDBURL for calls against the ArangoDB API
    .DESCRIPTION
        Set's the ArangoDBToken, ArangoDBHeader and ArangoDBURL for calls against the ArangoDB API
    .NOTES
        Name: Set-Environment
        Author: Morten Johansen
        Version: 0.0.1
        DateCreated: 2022-June-11
        DateUpdated: 2022-November-10
    .PARAMETER Url
        Url of ArangoDB
    .PARAMETER Port
        Port of ArangoDB
    .PARAMETER User
        Username for accessing ArangoDB
    .PARAMETER Pass
        Password for accessing ArangoDB
    .PARAMETER Database
        Name of the database to work against
    .EXAMPLE
        Set-Environment -Url 'https://arangodb.domain.com' -Port '8529' -User 'sa_someuser' -Pass 'secret_password' -Database 'test_DB'
        Will set all global variables for the ArangoDB environment
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true,Position=0,HelpMessage='Enter url of ArangoDB.')]
        [string]$Url,
        [Parameter(Mandatory=$true,Position=1,HelpMessage='Enter port of ArangoDB.')]
        [string]$Port,
        [Parameter(Mandatory=$true,Position=2,HelpMessage='Enter username of ArangoDB.')]
        [string]$User,
        [Parameter(Mandatory=$true,Position=3,HelpMessage='Enter password of ArangoDB.')]
        [string]$Pass,
        [Parameter(Mandatory=$true,Position=4,HelpMessage='Enter name of the database to work against.')]
        [string]$Database
    )
    try {
        $json = @{username="$($User)";password="$($Pass)";} | ConvertTo-Json
        $jwt = (Invoke-RestMethod $Url":"$Port/_open/auth -Body $json -Method Post).jwt
        $headers = @{
            "Authorization" = "Bearer $jwt"
            "Content-Type" = "application/json; charset=utf-8"
        }
        Set-Variable -Name ArangoDBToken -Scope Global -Value $jwt
        Set-Variable -Name ArangoDBHeader -Scope Global -Value $headers
        Set-Variable -Name ArangoDBURL -Scope Global -Value $Url
        Set-Variable -Name ArangoDBPort -Scope Global -Value $Port
        Set-Variable -Name ArangoDBDatabase -Scope Global -Value $Database
        Set-Variable -Name ArangoDBAPIUrl -Scope Global -Value $Url":"$Port"/_db/"$Database"/_api/"
    }
    catch {
        Write-Host "Failed to set the global variables!" -ForegroundColor red
        Write-Host "Exception Message: $($_.Exception.Message)" -ForegroundColor Red
        break
    }
}