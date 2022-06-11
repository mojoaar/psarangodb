function Test-Environment {
    <#
    .SYNOPSIS
        Private function to check if the environment values are set
    .DESCRIPTION
        Private function to check if the environment values are set
    .NOTES
        Name: Test-Environment
        Author: Morten Johansen
        Version: 0.0.1
        DateCreated: 2022-June-11
        DateUpdated: XXXX-XXX-XX
    .EXAMPLE
        Test-Environment
        Will test if the ArangoDB API environment is set
    #>
    if (!$Global:ArangoDBToken -or !$Global:ArangoDBHeader -or !$Global:ArangoDBURL) {
        Write-Host "Authentication, API Headers, or API base URL for ArangoDB API are not set (one or more), please use Set-Environment before running this function" -ForegroundColor Red
        break
    } else {
        $true
    }
}