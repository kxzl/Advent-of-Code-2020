$MinListe = Get-Content -Path "C:\Users\roman\OneDrive\Desktop\AoC\D4_Input\Input.txt" -Raw 
#$MinListe = Get-Content -Path "C:\Users\roman\OneDrive\Desktop\AoC\D4_Input\test.txt" -Raw 

$nl = [System.Environment]::NewLine
$passListe = ($MinListe -split "$nl$nl") | Foreach {$_ -replace "`r`n",' '}


#byr (Birth Year)
#iyr (Issue Year)
#eyr (Expiration Year)
#hgt (Height)
#hcl (Hair Color)
#ecl (Eye Color)
#pid (Passport ID)
#cid (Country ID)

$rx = "(?=.*?\bbyr\b)(?=.*?\biyr\b)(?=.*?\beyr\b)(?=.*?\bhgt\b)(?=.*?\bhcl\b)(?=.*?\becl\b)(?=.*?\bpid\b)^.*$"

$AntallGyldigePass = 0

foreach ($pass in $passListe) {
    if ($pass -match $rx) {
        $AntallGyldigePass = $AntallGyldigePass + 1
    }
}

Write-Output "AntallGyldigePass: $AntallGyldigePass"