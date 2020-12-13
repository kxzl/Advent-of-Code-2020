
function Setekalk($NySeteMatrise) {

    #Bortover
    $Tot_x = ($SetteMatrise[0]).Length
    #nedover
    $Tot_y = $SetteMatrise.Length
    $NySeteMatrise = $SetteMatrise.Clone()

    for ($y=0; $y -lt $Tot_y; $y++) {
        for ($x=0; $x -lt $Tot_x; $x++) {
            $Sette = $SetteMatrise[$y][$x]
        
            if($Sette -eq ".") {
                #Hopp til neste
                continue
            }
        
                
            #Kalkuler Nabosetter Indeks matrise, start øvre venstre hjørne
            $NaboSetter = @()      

            for ($q=-1; $q -le 1; $q++) {
                for ($w=-1; $w -le 1; $w++) {
                    if ((($x+$w) -lt 0) -or (($y+$q) -lt 0) -or (($x+$w) -gt $Tot_x-1) -or (($y+$q) -gt $Tot_y-1)) {
                        $NaboSetter += "."
                    } elseif ((($x+$w) -eq $x) -and (($y+$q) -eq $y)) {
                        # Ikke gjør noe, dette er vårt valgte sete
                    }else { 
                        $NaboSetter += $SetteMatrise[$y+$q][$x+$w]
                    }
                }
            }


            #Endre NySeteMatrise etter gitte regler
        
            if ($Sette -eq "L") {
                if (!(($NaboSetter | Where-Object {$_ -eq "#"}).count -gt 0)) {
                    $NySeteMatrise[$y] = (($NySeteMatrise[$y]).Remove($x,1)).insert($x,"#")
                }
            } elseif ($Sette -eq "#") {

                if ((($NaboSetter | Where-Object {$_ -eq "#"}).count -ge 4)){
                    #$NySeteMatrise[$y][$x] = "L"
                    $NySeteMatrise[$y] = (($NySeteMatrise[$y]).Remove($x,1)).insert($x,"L")
                }
            }

        }  

    
    }

    Write-Output $NySeteMatrise

}


[string[]]$SetteMatrise = Get-Content -Path ".\D11_Input\test.txt"


$NyMatrise = @()
$counter = 1
# Loop maskjiten til det ikke er noen endringer
While ($true) {
    
    $NyMatrise = Setekalk $SetteMatrise
    $diff = (Compare-Object -ReferenceObject $SetteMatrise -DifferenceObject $NyMatrise)
    
    if ($diff -ne $null) {
        $SetteMatrise = $NyMatrise.clone()   
    } else {
        # VI HAR ET SVAR!
        $AntallOpptatteSeter = (("$NyMatrise").ToCharArray() | Where-Object {$_ -eq "#"}).count
        Write-Output "Opptatte seter: $AntallOpptatteSeter"
        break
    }

    Write-Output "Iteration: $counter"
    $counter++    
} 

