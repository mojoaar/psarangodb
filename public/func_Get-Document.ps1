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
    .PARAMETER Collection
        Collection to query in ArangoDB
    .PARAMETER Key
        Key to query in ArangoDB
    .PARAMETER All
        Switch to query all entries in ArangoDB collection
    .EXAMPLE
        Get-Document -Collection 'test_collection' -Key '1234'
        Get document with id 1234 from the collection test_collection
    .EXAMPLE
        Get-Document -Collection 'test_collection' -All
        Get all documents from the collection test_collection
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true,Position=0,HelpMessage='Enter the collection to query.')]
        [string]$Collection,
        [Parameter(Mandatory=$true,Position=1,ParameterSetName='singleDocument',HelpMessage='Enter the collection Key to query.')]
        [string]$Key,
        [Parameter(Mandatory=$false,Position=2,ParameterSetName='multiDocument',HelpMessage='Switch to list all documents from the collection.')]
        [switch]$All
    )
    if(!(Test-Environment)) {
        $_
    }
    if ($PSCmdlet.ParameterSetName -eq 'singleDocument') {
        try {
            Invoke-RestMethod -Uri $Global:ArangoDBAPIUrl"/document/"$Collection"/"$Key -Headers $Global:ArangoDBHeader 
        }
        catch {
            Write-Host "There was an error in your web request!" -ForegroundColor red
            Write-Host "Exception Message: $($_.Exception.Message)" -ForegroundColor Red
            break
        }
    }
    if($All -and $PSCmdlet.ParameterSetName -eq 'multiDocument') {
        try {
            $query =  @{query="FOR x IN $Collection RETURN x";} | ConvertTo-Json
            $query = Invoke-RestMethod -Uri $Global:ArangoDBAPIUrl"/cursor" -Headers $Global:ArangoDBHeader -Method Post -Body $query
            $results = [System.Collections.ArrayList]@()
            $query.foreach({$results.add($_)}) | Out-Null
            if($query.hasMore -eq $true) {
                do {
                    $query = Invoke-RestMethod -Uri $Global:ArangoDBAPIUrl"/cursor/$($query.id)" -Headers $Global:ArangoDBHeader -Method Post -Body $query
                    $query.foreach({$results.add($_)}) | Out-Null
                } until ($query.hasMore -eq $false)
                return $results.result
            } else {
                return $results.result
            }
        }
        catch {
            Write-Host "There was an error in your web request!" -ForegroundColor red
            Write-Host "Exception Message: $($_.Exception.Message)" -ForegroundColor Red
            break
        }
    }
}