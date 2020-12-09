    #$MinListe = Get-Content -Path ".\D8_Input\test.txt"
    $MinListe = Get-Content -Path ".\D8_Input\Input.txt"


function FinnAcc ($MinInput) {
    [regex]$rx_tall = "((\+|\-)\d+)"

    $Observed_idx = @()
    $Avbryt = $true
    $idx = 0
    $killswitch = 0
    $acc = 0
    $i = 1
   

    :red While ($Avbryt) {
        # Index Stuff
        #Write-Output "IDX: $idx"
        #Write-Output "acc: $acc"
        if ($Observed_idx.Contains($idx)) {
            #Killswitch Engage!
            #Write-Output "Killswitch Engage!"
            $Avbryt = $false
            $acc = "nope"
            break red
        } 

        $Observed_idx +=$idx
        #Read instruction Line
        $Line = $MinInput[$idx]
        [string]$op = $rx_tall.Match($Line).Value
        #Write-Output "Line: $Line og I: $i og Acc: $acc"
        if ($Line -eq $null){
            #Write-Output "Done!"
            break red
        }

        if ($Line.Contains("nop")) {
            #$acc++
            $idx++
        } elseif ($Line.Contains("acc")) 
        {
            
            $acc = Invoke-Expression "$acc $op"
            $idx++
        } elseif ($Line.Contains("jmp")) 
        {
            $idx = Invoke-Expression "$idx $op"
        }
        


        #Killswitch for 
        #if ($killswitch -gt 0) {
        #    $Avbryt = $false
        #}
        #$killswitch ++
        $i++
    } 

return $acc

}


for ($z = 0; $z -lt $MinListe.Length; $z++) {
    #Write-Output $MinListe[$z]
    [regex]$rex_op = "\w{3}"
    $NyListe = @()
    $NyListe += $MinListe 
    $res = "nope"
    $operasjon = $rex_op.Match($MinListe[$z]).Value

    if ($($operasjon) -eq "nop") {
        $NyListe[$z] = $MinListe[$z] -replace "nop", "jmp"
        $res = $(FinnAcc $NyListe)

    } elseif ($($operasjon) -eq "jmp") {
        $NyListe[$z] = $MinListe[$z] -replace "jmp", "nop"
        $res = $(FinnAcc $NyListe)
    }

    if ($res -ne"nope") {
        Write-Output "Acc: $res"
        break
    }
    #$NyListe = @()
}

#Write-Output $(FinnAcc $MinListe)