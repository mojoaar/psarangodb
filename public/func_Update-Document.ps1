function Update-Document {
    <#
    .SYNOPSIS
        Update document in a collection
    .DESCRIPTION
        Update document in a collection
    .NOTES
        Name: Update-Document
        Author: Morten Johansen
        Version: 0.0.1
        DateCreated: 2022-June-12
        DateUpdated: XXXX-XXX-XX
    .PARAMETER Collection
        Collection where the document is located
    .PARAMETER Key
        Key of the document to update
    .PARAMETER Data
        Data to update (as json)
    .EXAMPLE
        $json = @{display_name="John Doe";} | ConvertTo-Json
        Update-Document -Collection 'test_collection' -Key '9436' -Data $json
        Update document 9436 in the collection test_collection
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true,Position=0,HelpMessage='Enter collection where the document is located.')]
        [string]$Collection,
        [Parameter(Mandatory=$true,Position=1,HelpMessage='Enter key of the document to update.')]
        [string]$Key,
        [Parameter(Mandatory=$true,Position=2,HelpMessage='Data to update (json).')]
        [string]$Data
    )
    if(!(Test-Environment)) {
        $_
    }
    try {
        Invoke-RestMethod -Uri $Global:ArangoDBAPIUrl"document/"$Collection"/"$Key -Headers $Global:ArangoDBHeader -Method Patch -Body $Data -ContentType 'application/json; charset=utf-8'
    }
    catch {
        Write-Host "There was an error in your web request!" -ForegroundColor red
        Write-Host "Exception Message: $($_.Exception.Message)" -ForegroundColor Red
        break
    }
}