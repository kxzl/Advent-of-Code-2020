$MinListe = Get-Content -Path "C:\Users\roman\OneDrive\Desktop\AoC\D6_Input\Input.txt" -Raw 
#$MinListe = Get-Content -Path "C:\Users\roman\OneDrive\Desktop\AoC\D6_Input\test.txt" -Raw 

$nl = [System.Environment]::NewLine
$GruppeListe = ($MinListe -split "$nl$nl") | Foreach {$_ -replace "`r`n",' '}

#$AlleSpormaal = [char[]](97..122)
$EnigeSvar = 0
foreach ($GruppeSvar in $GruppeListe) {
    $Gruppe = $GruppeSvar -split " "
    $AntallPersoner = $Gruppe.Length
    $SamletGruppeSvar = $Gruppe.TOCharArray() | Group-Object -NoElement

    foreach ($Svar in $SamletGruppeSvar) {
        if ($Svar.Count -eq $AntallPersoner) {
            $EnigeSvar = $EnigeSvar + 1
        }
    }

    #for ($i= 0; $i -lt $Gruppe.Length; $i++ ) {
    #    for ($z=0; $z -lt $Gruppe[$i].Length; $z++ ) {
    #        Write-Output "z: $z"
    #        Write-Output "i: $i"
    #        Write-Output "B: $($Gruppe[$i][$z])"
    #    }
    #
    #}

  
        #Write-Output $Personer
        #Write-Output "-----------"
    
    #Write-Output "###########"
}

Write-Output "Enige Svar: $EnigeSvar"