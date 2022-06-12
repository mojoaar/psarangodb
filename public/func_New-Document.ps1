function New-Document {
    <#
    .SYNOPSIS
        Create new document in collection
    .DESCRIPTION
        Create new document in collection
    .NOTES
        Name: New-Document
        Author: Morten Johansen
        Version: 0.0.1
        DateCreated: 2022-June-11
        DateUpdated: XXXX-XXX-XX
    .PARAMETER Collection
        Collection to add the document to
    .PARAMETER Data
        Data to add (as json)
    .EXAMPLE
        $json = @{display_name="John Doe";title="Director";email="john@doe.com";} | ConvertTo-Json
        New-Document -Collection 'test_collection' -Data $json
        Add a new document to the collection test_collection
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true,Position=0,HelpMessage='Enter collection to add the document to.')]
        [string]$Collection,
        [Parameter(Mandatory=$true,Position=1,HelpMessage='Data to add (json).')]
        [string]$Data
    )
    if(!(Test-Environment)) {
        $_
    }
    try {
        Invoke-RestMethod -Uri $Global:ArangoDBAPIUrl"document/"$Collection -Headers $Global:ArangoDBHeader -Method Post -Body $Data
    }
    catch {
        Write-Host "There was an error in your web request!" -ForegroundColor red
        Write-Host "Exception Message: $($_.Exception.Message)" -ForegroundColor Red
        break
    }
}