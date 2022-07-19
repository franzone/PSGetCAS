# PSGetCAS
Get-CAS script provides a PowerShell interface to the Apereo CAS Initializr on Heroku.

## Command-Line Help
You can view this help by invoking the script with the `-help` switch.

```
NAME
    Get-CAS.ps1
    
SYNOPSIS
    Get-CAS script provides a PowerShell interface to the Apereo CAS Initializr on Heroku.
    
    
SYNTAX
    Get-CAS.ps1 [[-url] <String>] [[-projectType] <String>] [[-directory] <String>] 
    [[-casVersion] <String>] [[-bootVersion] <String>] [[-dependencies] <String>] [-listDependencies] [-help] 
    [<CommonParameters>]
    
    
DESCRIPTION
    The CAS project provides a public free instance of the CAS Initializr on Heroku,
    paid for by the Apereo CAS support subscribers. (from https://apereo.github.io)
    The CAS project also gives an example of a BASH script to create a command-line
    interface to the CAS Initializr. This is a PowerShell alternative for those
    working on the MS Windows platform.
    

PARAMETERS
    -url <String>
        URL to the CAS Initializr (default = https://casinit.herokuapp.com/starter.tgz)
        
    -projectType <String>
        The CAS Initializr can create overlays for these different types of projects.
        * cas-overlay                  : CAS Instance (default)
        * cas-bootadmin-server-overlay : Overlay for the Spring Boot Admin Server
        * cas-config-server-overlay    : Spring Cloud Configuration Server
        * cas-discovery-server-overlay : Service Discovery Server
        * cas-management-overlay       : CAS Management Web Application
        
    -directory <String>
        The name of the directory in which to place the generated project (default = "overlay")
        
    -casVersion <String>
        Specify the CAS version for the overlay
        
    -bootVersion <String>
        Specify the Spring Boot version for the overlay
        
    -dependencies <String>
        Include specific dependencies in the CAS overlay
        
    -listDependencies [<SwitchParameter>]
        This calls the CAS Initializr endpoint to list the possible CAS dependencies
        
    -help [<SwitchParameter>]
        Print this help
        
    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see 
        about_CommonParameters (https:/go.microsoft.com/fwlink/?LinkID=113216). 
    
    -------------------------- EXAMPLE 1 --------------------------
    
    PS C:\>.\Get-CAS.ps1 -dependencies duo,oidc
    
    -----------
    Description 
    Generate a basic CAS WAR Overlay project with DUO Multifactor and Open ID Client dependencies
    
    
    
    
    -------------------------- EXAMPLE 2 --------------------------
    
    PS C:\>.\Get-CAS.ps1 -casVersion v6.5.6
    
    -----------
    Description 
    Generate a basic CAS WAR Overlay project with dependencies and version v6.5.6
    
    
    
    
REMARKS
    To see the examples, type: "get-help .\Get-CAS.ps1 -examples".
    For more information, type: "get-help .\Get-CAS.ps1 -detailed".
    For technical information, type: "get-help .\Get-CAS.ps1 -full".

```

## Author
The author of this script is Jonathan Franzone (that's me!). You can find more information about him at:
* https://franzone.blog
* https://about.franzone.com
* https://www.linkedin.com/in/jonathanfranzone/

## License
[MIT License](LICENSE)
