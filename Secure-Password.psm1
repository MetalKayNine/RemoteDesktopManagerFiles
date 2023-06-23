function Secure-Password ([string]$RDCManFile,[string]$password) {
    if (-not(test-path "$($env:temp)\RDCMan.dll")) {
       copy-item "$RDCManFile" "$($env:temp)\RDCMan.dll"
    }
    Import-Module "$($env:temp)\RDCMan.dll"
    $EncryptionSettings = New-Object -TypeName RdcMan.EncryptionSettings
    [RdcMan.Encryption]::EncryptString($password, $EncryptionSettings)
 }