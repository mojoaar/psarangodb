function Remove-Document {
    <#
    .SYNOPSIS
        Remove document in a collection
    .DESCRIPTION
        Remove document in a collection
    .NOTES
        Name: Remove-Document
        Author: Morten Johansen
        Version: 0.0.1
        DateCreated: 2022-June-12
        DateUpdated: XXXX-XXX-XX
    .PARAMETER Collection
        Collection where the document is located
    .PARAMETER Key
        Key of the document to remove
    .EXAMPLE
        Remove-Document -Collection 'test_collection' -Key '9436'
        Remove document 9436 in the collection test_collection
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true,Position=0,HelpMessage='Enter collection where the document is located.')]
        [string]$Collection,
        [Parameter(Mandatory=$true,Position=1,HelpMessage='Enter key of the document to delete.')]
        [string]$Key
    )
    if(!(Test-Environment)) {
        $_
    }
    try {
        Invoke-RestMethod -Uri $Global:ArangoDBAPIUrl"document/"$Collection"/"$Key -Headers $Global:ArangoDBHeader -Method Delete
    }
    catch {
        Write-Host "There was an error in your web request!" -ForegroundColor red
        Write-Host "Exception Message: $($_.Exception.Message)" -ForegroundColor Red
        break
    }
}