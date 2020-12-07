#Funksjoner
Function SetteKalkulator($SetteArray, $Sette_rad, $Sette_Kolonne) {
[hashtable]$return = @{}


    for ($i = 0; $i -lt $SetteArray.Length; $i++) {
        
        $Bokstav = $SetteArray[$i]
        

        if ($Bokstav -match "(F|B)") {
            # for rader
            
            $midindex = [Math]::Floor(($Sette_rad.length)/2)

            if ($Bokstav -eq "F") {
                $z = $midindex-1
                $Sette_rad = $Sette_rad[0..$z]
                Write-Output "z $z"
            } else {
                $z = ($Sette_rad.length-1)
                $Sette_rad = $Sette_rad[$midindex..$z]
            }
        }
        
        
        if ($Bokstav -match "(L|R)") {
            # for kolloner 
            $midindex = [Math]::Floor(($Sette_Kolonne.length)/2)

            if ($Bokstav -eq "L") {
                $z = $midindex-1
                $Sette_Kolonne = $Sette_Kolonne[0..$z]
            } else {
                $z = ($Sette_Kolonne.length-1)
                $Sette_Kolonne = $Sette_Kolonne[$midindex..$z]
            }
        }
        
           
    } 
    

    $return.Add("Rad", $Sette_rad[0])
    $return.Add("Kolonne", $Sette_Kolonne[0])
    $return.Add("ID", $Sette_rad[0]*8 + $Sette_Kolonne[0])
    return $return
    
}


$MinListe = Get-Content -Path "C:\Users\roman\OneDrive\Desktop\AoC\D5_Input\Input.txt"
#$MinListe = Get-Content -Path "C:\Users\roman\OneDrive\Desktop\AoC\D5_Input\test.txt"

$Sette_rad = 0..127
$Sette_Kolonne = 0..7


[Array]$SetteID = @()
foreach ($Sette in $MinListe) {
    $SetteArray = $Sette.ToCharArray()
    $resultat = $(SetteKalkulator $SetteArray $Sette_rad $Sette_Kolonne)
    $SetteID += ($resultat.ID)
    #Write-Output "Sette er på RAD: $($resultat.Rad) og KOLONE: $($resultat.Kolonne) og ID: $($resultat.ID)"
}


$SetteID = $SetteID | Sort
$Count = $(($SetteID | measure -Minimum).Minimum)+1

for ($q=1; $q -lt $SetteID.Length-1; $q++) {
    
    if (($SetteID[$q] -ne $Count) -and ($SetteID[$q] -eq $Count+1) -and ($SetteID[$q-1] -eq $Count-1)) {

        Write-Output "Mitt Sette: $($Count)"
        Write-Output "Sette -1: $($SetteID[$q-1])"
        Write-Output "Sette +1: $($SetteID[$q])"
        Write-Output "Counter: $Count"
        #break
    }
    $Count = $Count + 1
}

#Write-Output "Max ID: $(($SetteID | measure -Maximum).Maximum)"