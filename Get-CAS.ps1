<#
.SYNOPSIS
    Get-CAS script provides a PowerShell interface to the Apereo CAS Initializr on Heroku.

.DESCRIPTION
    The CAS project provides a public free instance of the CAS Initializr on Heroku,
    paid for by the Apereo CAS support subscribers. (from https://apereo.github.io)
    The CAS project also gives an example of a BASH script to create a command-line
    interface to the CAS Initializr. This is a PowerShell alternative for those
    working on the MS Windows platform.

.PARAMETER url
    URL to the CAS Initializr (default = https://casinit.herokuapp.com/starter.tgz)
.PARAMETER projectType
    The CAS Initializr can create overlays for these different types of projects.
    * cas-overlay                  : CAS Instance (default)
    * cas-bootadmin-server-overlay : Overlay for the Spring Boot Admin Server
    * cas-config-server-overlay    : Spring Cloud Configuration Server
    * cas-discovery-server-overlay : Service Discovery Server
    * cas-management-overlay       : CAS Management Web Application
.PARAMETER directory
    The name of the directory in which to place the generated project (default = "overlay")
.PARAMETER casVersion
    Specify the CAS version for the overlay
.PARAMETER bootVersion
    Specify the Spring Boot version for the overlay
.PARAMETER dependencies
    Include specific dependencies in the CAS overlay
.PARAMETER listDependencies
    This calls the CAS Initializr endpoint to list the possible CAS dependencies
.PARAMETER help
    Print this help

.EXAMPLE
    Get-CAS -dependencies duo,oidc
    -----------
    Description 
    Generate a basic CAS WAR Overlay project with DUO Multifactor and Open ID Client dependencies

.EXAMPLE
    Get-CAS -casVersion v6.5.6
    -----------
    Description 
    Generate a basic CAS WAR Overlay project with dependencies and version v6.5.6

.NOTES
    Author: Jonathan Franzone
    Website: https://about.franzone.com
#>
param (
    [string] $url = 'https://casinit.herokuapp.com/starter.zip',
    [string] $projectType = 'cas-overlay',
    [string] $directory = 'overlay',
    [string] $casVersion,
    [string] $bootVersion,
    [string] $dependencies,
    [switch] $listDependencies,
    [switch] $help
)

if ($help) {
    Get-Help $MyInvocation.MyCommand.Path -Detailed
}

elseif ($listDependencies) {

    $myUri = [System.Uri]$url
    $uriParts = $myUri.Segments
    $uriParts[$uriParts.Length - 1] = 'dependencies'
    $depUrl = $myUri.Scheme + "://" + $myUri.Authority + -Join $uriParts
    $Response = Invoke-WebRequest $depUrl
    $json = [System.Text.Encoding]::UTF8.GetString($Response.Content)
    $depList = ConvertFrom-Json -InputObject $json

    Write-Host 'Dependencies:'
    Write-Host '=================================================='
    ForEach ($dep in $depList.dependencies.PSObject.Properties) {
        Write-Host "    - " + $dep.Name
    }
}

else {

    $myProjectType = if(-Not([string]::IsNullOrWhiteSpace($projectType))) { $projectType } else { "cas-overlay" }
    $body = @{
        projectType = "${myProjectType}"
    }

    $myDirectory = "-d baseDir="
    if (-Not([string]::IsNullOrWhiteSpace($directory))) {
        $body += @{ baseDir = "${directory}" }
    }
    else {
        $body += @{ baseDir = "overlay" }
    }

    if (-Not([string]::IsNullOrWhiteSpace($casVersion))) {
        $body += @{ caseVersion = "${casVersion}" }
    }

    if (-Not([string]::IsNullOrEmpty($dependencies))) {
        $body += @{ dependencies = "${dependencies}" }
    }

    if (-Not([string]::IsNullOrWhiteSpace($bootVersion))) {
        $body += @{ bootVersion = "${bootVersion}" }
    }

    Write-Host '=================================================='
    Write-Host 'Generating CAS Overlay Project'
    Write-Host '=================================================='
    Write-Host "URL          : ${url}"
    Write-Host "PROJECT-TYPE : ${projectType}"
    Write-Host "DIRECTORY    : ${directory}"
    Write-Host "CAS-VERSION  : ${casVersion}"
    Write-Host "BOOT-VERSION : ${bootVersion}"
    Write-Host "DEPENDENCIES : ${dependencies}"
    Write-Host '=================================================='

    $payload = ConvertTo-Json -InputObject $body
    $Response = Invoke-WebRequest -Uri $url -Method POST -Body $payload -OutFile "cas.zip"
    Expand-Archive -Path "cas.zip"
    Remove-Item cas.zip
}
