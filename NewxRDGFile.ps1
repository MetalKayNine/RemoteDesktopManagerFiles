import-module ./New-xRDGFile.psm1
Import-Module D:\Code\NYUPSv2\Modules\New-xExchSession

$exchSess = New-xExchSession

Import-PSSession -Session $exchSess -AllowClobber

$MailboxServers = Get-MailboxServer | Select-Object -ExpandProperty Name

New-xRDGFile -List $MailboxServers -OutputFileName "Exchange2019MbxServers"
