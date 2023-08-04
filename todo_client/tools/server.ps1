$path = "$PSScriptRoot/powershell/process"
$connectionPath = "$PSScriptRoot/powershell/port_check"
& $path;
$connected = & $connectionPath;
if(!$connected) {
    Set-Location ..;
    Set-Location ".\todo_server";
    Clear-Host; 
    npm run dev;
}
