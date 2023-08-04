Param(
    [Parameter(Mandatory = $false)]
    [String] $path = $Global:xampp,
    [Parameter(Mandatory = $false)]
    [String] $name = 'xampp-control'
); 
# *User single qoute when defining default [String] value!
# *When starting a process [FilePath] shouldn't end with a ["\"]!

$process = Get-Process $name -ErrorAction SilentlyContinue;
if (!$process) {
    Start-Process $path -Verb RunAs -WindowStyle Minimized;
} 