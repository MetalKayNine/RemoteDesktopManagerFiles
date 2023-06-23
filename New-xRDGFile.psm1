Function New-xRDGFile{
    Param(
        [Parameter(Mandatory=$true,Position=0)]
        [string[]]$List,
        [Parameter(Mandatory=$true,Position=1)]
        [string]$OutputFileName
    )
    Begin{
    
$Top = @"
<?xml version="1.0" encoding="utf-8"?>
<RDCMan programVersion="2.7" schemaVersion="3">
  <file>
    <credentialsProfiles />
    <properties>
      <expanded>True</expanded>
      <name>$($OutputFileName)</name>
    </properties>
    <logonCredentials inherit="None">
      <profileName scope="Local">Custom</profileName>
      <userName>xuy06</userName>
      <password></password>
      <domain>NYUMC</domain>
    </logonCredentials>
    <remoteDesktop inherit="None">
      <sameSizeAsClientArea>True</sameSizeAsClientArea>
      <fullScreen>False</fullScreen>
      <colorDepth>24</colorDepth>
    </remoteDesktop>
    <securitySettings inherit="None">
      <authentication>None</authentication>
    </securitySettings>
"@
$bottom = @"
</file>
  <connected />
  <favorites />
  <recentlyUsed />
</RDCMan>
"@
    $DesktopPath = [System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::Desktop)
    $filePath = Join-Path -Path $DesktopPath -ChildPath "$($OutputFileName).rdg"
    }
    process{
        Add-Content -Path $filePath -Value $Top
        $List | ForEach-Object {
$serverInfo = @"
    <server>
      <properties>
        <displayName>$($_.toupper())</displayName>
        <name>psm.nyumc.org</name>
      </properties>
      <connectionSettings inherit="None">
        <connectToConsole>False</connectToConsole>
        <startProgram>psm /u msgadmacct@nyumc.org /a $($_.toupper()) /c PSM-RDP-MAP</startProgram>
        <workingDir />
        <port>3389</port>
        <loadBalanceInfo />
      </connectionSettings>
    </server>
"@
            Add-Content -Path $filePath -Value $serverInfo 
        }
        Add-Content -Path $filePath -Value $bottom 
    }
    end{
        return "RDG file generated at $($filePath)"
    }
}