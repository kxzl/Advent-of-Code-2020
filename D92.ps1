#$MinListe = Get-Content -Path ".\D9_Input\test.txt"
#$cont_num = 127
$MinListe = Get-Content -Path ".\D9_Input\Input.txt"
$cont_num = 556543474
$tallet = 0
$lengde = $MinListe.Length
#[array]::Reverse($MinListe)

:outer for ($i = 0; $i -lt $lengde; $i++) {
    $z_lengde = $($MinListe[$i..($MinListe.Length-1)]).Length
    :inner for ($z = 0; $z -le $z_lengde; $z++ ) {
        $cont_list = @()
        $cont_list += $MinListe[$i..($i+$z)]
        $ct = ($cont_list | measure -Minimum -Maximum -Sum)
        $diff = $(($ct.Sum) - $cont_num)

        #if ($diff -lt -1000000) {
        #    Write-Output "Idx: $i av $lengde -- Sum: $($ct.Sum) -- Target: $cont_num -- Diff: $($cont_num - ($ct.Sum))"
        #    break inner
        #}


        if ($($ct.Sum) -eq $cont_num) {
            
            $tallet = $ct.Minimum+$ct.Maximum
            #Write-Output "hei"
            #Write-Output $ct
            #Write-Output $cont_list
            #Write-Output "---------"
            break outer    
        
        } elseif ($($ct.Sum)  -gt $cont_num) {
            Write-Output "i: $i av $lengde z: $z av $z_lengde -- Sum: $($ct.Sum) -- Target: $cont_num -- Diff: $diff"
            #Write-Output $ct
            #Write-Output $cont_list
            #Write-Output "---------"
            break inner
        }

    }


}  


Write-Output "Taller er: $tallet"

#$cont_num = 127
#$cont_num = 556543474