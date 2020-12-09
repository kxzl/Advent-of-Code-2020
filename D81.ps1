    #$MinListe = Get-Content -Path ".\D8_Input\test.txt"
    $MinListe = Get-Content -Path ".\D8_Input\Input.txt"

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
            Write-Output "Killswitch Engage!"
            $Avbryt = $false
            break red
        }

        $Observed_idx +=$idx
        #Read instruction Line
        $Line = $MinListe[$idx]
        [string]$op = $rx_tall.Match($Line).Value
        #Write-Output "Line: $Line og I: $i og Acc: $acc"
        if ($Line -eq $null){
            Write-Output "Ingen instruksjoner funnet på index: $idx"
            break
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


Write-Output "Acc: $acc"