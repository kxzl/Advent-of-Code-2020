$MinListe = Get-Content -Path "C:\Users\roman\OneDrive\Desktop\AoC\D4_Input\Input.txt" -Raw 
#$MinListe = Get-Content -Path "C:\Users\roman\OneDrive\Desktop\AoC\D4_Input\test2.txt" -Raw 

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
        $checklist = 0
        
        #1 byr sjekkliste
        if ($pass -match "(?<=byr\:)(\d\d\d\d)") {
            
            if (($Matches[0] -le 2002) -and ($Matches[0] -ge 1920)) {
                #Write-Output "-------------"
                #Write-Output "byr: $($Matches[0])"
                $checklist = $checklist + 1
            }
        
        }

        #2 iyr sjekkliste
        if ($pass -match "(?<=iyr\:)(\d\d\d\d)") {
            
            if (($Matches[0] -le 2020) -and ($Matches[0] -ge 2010)) {
                #Write-Output "-------------"
                #Write-Output "iyr: $($Matches[0])"
                $checklist = $checklist + 1
            }
        
        }

        #3 eyr sjekkliste
        if ($pass -match "(?<=eyr\:)(\d\d\d\d)") {
            
            if (($Matches[0] -le 2030) -and ($Matches[0] -ge 2020)) {
                #Write-Output "-------------"
                #Write-Output "eyr: $($Matches[0])"
                $checklist = $checklist + 1
            }
        
        }
        
        #4.1 hgt sjekkliste cm (3 tall)
        if ($pass -match "(?<=hgt\:)(\d\d\d)(?=cm)") {
            
            if (($Matches[0] -le 193) -and ($Matches[0] -ge 150)) {
                #Write-Output "-------------"
                #Write-Output "eyr: $($Matches[0])"
                $checklist = $checklist + 1
            }
        
        }

        #4.2 hgt sjekkliste in (2 tall)
        if ($pass -match "(?<=hgt\:)(\d\d)(?=in)") {
            
            if (($Matches[0] -le 76) -and ($Matches[0] -ge 59)) {
                #Write-Output "-------------"
                #Write-Output "eyr: $($Matches[0])"
                $checklist = $checklist + 1
            }
        
        }

        #5 hcl sjekkliste
        if ($pass -match "(?<=hcl\:#)(.{6}(\s|$))") {
            
                #Write-Output "-------------"
                #Write-Output "eyr: $($Matches[0])"
                $checklist = $checklist + 1
        }
        
        

        #6 ecl sjekkliste
        if ($pass -match "(?<=ecl\:)(amb|blu|brn|gry|grn|hzl|oth)") {
            
                #Write-Output "-------------"
                #Write-Output "eyr: $($Matches[0])"
                $checklist = $checklist + 1
        }
        
        

        #7 pid sjekkliste
        if ($pass -match "(?<=pid\:)(\d{9}(\s|$))") {
            
                #Write-Output "-------------"
                #Write-Output "eyr: $($Matches[0])"
                $checklist = $checklist + 1
        }
        
        
        #summering av passerte sjekk
        if ($checklist -eq 7) {
            $AntallGyldigePass = $AntallGyldigePass + 1
        } else {
            #Write-Output "Pass: $pass"
            #Write-Output "Antall sjekk passert: $checklist"
        }
    }
}

Write-Output "AntallGyldigePass: $AntallGyldigePass"