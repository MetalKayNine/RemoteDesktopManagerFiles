function Add-ServerToGroup($group, $serverName) {
    $serverElement = $serverTemplateElement.clone()
    $serverElement.properties.name = $serverName
 
    [void]$group.AppendChild($serverElement)
 }