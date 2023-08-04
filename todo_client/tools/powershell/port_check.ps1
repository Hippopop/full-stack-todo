Param(
    [Parameter(Mandatory = $false)]
    [int] $port = 8080
);

$connection = Get-NetTCPConnection -LocalPort $port -ErrorAction SilentlyContinue;
return $connection.State -eq 'Listen'; 