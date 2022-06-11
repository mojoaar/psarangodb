function Get-Document {
    <#
    .SYNOPSIS
        Get's a single or more documents from a collection
    .DESCRIPTION
        Get's a single or more documents from a collection
    .NOTES
        Name: Get-Document
        Author: Morten Johansen
        Version: 0.0.1
        DateCreated: 2022-June-11
        DateUpdated: XXXX-XXX-XX
    .EXAMPLE
        Get-Document -Collection 'test_collection' -ID '1234'
        Get document with id 1234 from the collection test_collection
    .EXAMPLE
        Get-Document -Collection 'test_collection' -All
        Get all documents from the collection test_collection
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true,Position=0,HelpMessage='Enter the collection to query.')]
        [string]$Collection,
        [Parameter(Mandatory=$false,Position=1,HelpMessage='Enter the collection id to query.')]
        [string]$ID,
        [Parameter(Mandatory=$false,Position=2,HelpMessage='Switch to list all documents from the collection.')]
        [switch]$All
    )
    if(!(Test-Environment)) {
        $_
    }
    if($All) {
        try {
            $query =  @{query="FOR x IN $Collection RETURN x";} | ConvertTo-Json
            (Invoke-RestMethod -Uri $Global:ArangoDBAPIUrl"/cursor" -Headers $Global:ArangoDBHeader -Method Post -Body $query).result
        }
        catch {
            Write-Host "There was an error in your web request!" -ForegroundColor red
            Write-Host "Exception Message: $($_.Exception.Message)" -ForegroundColor Red
            break
        }
    } else {
        try {
            Invoke-RestMethod -Uri $Global:ArangoDBAPIUrl"/document/"$Collection"/"$ID -Headers $Global:ArangoDBHeader 
        }
        catch {
            Write-Host "There was an error in your web request!" -ForegroundColor red
            Write-Host "Exception Message: $($_.Exception.Message)" -ForegroundColor Red
            break
        }
    }
}