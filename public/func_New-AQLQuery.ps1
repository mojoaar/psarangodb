function New-AQLQuery {
    <#
    .SYNOPSIS
        Run AQL query against ArangoDB
    .DESCRIPTION
        Run AQL query against ArangoDB
    .NOTES
        Name: New-AQLQuery
        Author: Morten Johansen
        Version: 0.0.1
        DateCreated: 2022-June-12
        DateUpdated: XXXX-XXX-XX
    .PARAMETER Query
        AQL query to run
    .EXAMPLE
        New-AQLQuery -Query 'RETURN DOCUMENT("some_collection/4608")'
        Return document 4608 from some_collection
    .EXAMPLE
        New-AQLQuery -Query 'FOR x IN some_collection RETURN x'
        Iterate thru alle documents in the collection some_collection
    .EXAMPLE
        New-AQLQuery -Query 'INSERT { display_name: "Katie Foster", title: "Student", email: "kf@domain.com" } INTO some_collection'
        Create a new document in the collection some_collection
    .EXAMPLE
        New-AQLQuery -Query 'INSERT { display_name: "Katie Foster", title: "Student", email: "kf@domain.com" } INTO some_collection RETURN NEW'
        Create a new document in the collection some_collection and return the newly created document
    .EXAMPLE
        New-AQLQuery -Query 'UPDATE "77420" WITH { display_name: "Luke Skywalker" } IN some_collection RETURN NEW'
        Update document 77420 in some_collection and return the updated document
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true,Position=0,HelpMessage='AQL query to run')]
        [string]$Query
    )
    if(!(Test-Environment)) {
        $_
    }
    try {
        $body =  @{query=$Query;} | ConvertTo-Json
        (Invoke-RestMethod -Uri $Global:ArangoDBAPIUrl"/cursor" -Headers $Global:ArangoDBHeader -Method Post -Body $body).result
    }
    catch {
        Write-Host "There was an error in your web request!" -ForegroundColor red
        Write-Host "Exception Message: $($_.Exception.Message)" -ForegroundColor Red
        break
    }
}