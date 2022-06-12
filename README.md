<p align="center">
<a href="https://github.com/mojoaar/psarangodb"><img src="https://img.shields.io/github/last-commit/mojoaar/psarangodb"></a>
<a href="https://github.com/mojoaar/psarangodb"><img src="https://img.shields.io/github/contributors/mojoaar/psarangodb"></a>
</p>
<p align="center">
<a href="https://technet.cc"><img src="https://img.shields.io/badge/technet.cc-Blog-blue"></a>
<a href="https://twitter.com/mojoaar"><img src="https://img.shields.io/twitter/follow/mojoaar?style=social"></a>
</p>

# PSArangoDB - PowerShell Module

This module provides a series of functions to work with the [ArangoDB](https://www.arangodb.com) API. Use Get-Help on the functions to get further details of usage.

## Requirements

Requires PowerShell 5.1 or above.

## Usage

### 1. PSGallery
Install module from PSGallery.
`Find-Module PSArangoDB -Repository PSGallery | Install-Module`
### 2. Manual
Download or clone the latest files and place the module folder in your PowerShell profile directory (i.e. the `Modules` directory under wherever `$profile` points to in your PS console) and run:
`Import-Module PSArangoDB`
Once you've done this, all the cmdlets will be at your disposal, you can see a full list using `Get-Command -Module PSArangoDB`. Remember to run Set-Environment before beginning to work with ArangoDB.

## Functions

* Get-Database
* Get-Document
* New-AQLQuery
* New-Document
* Remove-Document
* Set-Environment
* Update-Document

## Changelog

* 0.0.1 - 11-06-2022
  * Initial release of module