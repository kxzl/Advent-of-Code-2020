



function MaskConv ($mask, $value) {
    
    $value_bin = (([Convert]::ToString($value,2)).PadLeft(36,"0")).ToCharArray()
    $value_bin_new = [char[]]::new(36)
    for ($i=35; $i -ge 0;$i--){
        if ($mask[$i] -ne "X"){
            $value_bin_new[$i] = $mask[$i]
        } else {
            $value_bin_new[$i] = $value_bin[$i]
        }
    
    } 

    $value_new = [Convert]::ToUInt64($(-join $value_bin_new) ,2)

    Write-Output $value_new

}

function MaskAdressDestinations ([string]$mask, $value) {

    $value_bin = (([Convert]::ToString($value,2)).PadLeft(36,"0")).ToCharArray()
    $value_bin_new = [char[]]::new(36)
    $mask_char = $mask.ToCharArray()
    $res_array = @()
    $res_array_values = @()
    $count_x = 0
    $x_idx = @()


    for ($i=35; $i -ge 0;$i--){
    
        if ($mask[$i] -ne "0"){
            if ($mask[$i] -eq "X") {
                $x_idx += $i
                $count_x++
            }
            $value_bin_new[$i] = $mask_char[$i]
        } else {

            $value_bin_new[$i] = $value_bin[$i]
        }
    
    }


    $res_array += $(-join $value_bin_new)

    #loop til $res_array ikke har noen "X"er igjen og man har alle adressene
    :main while (($res_array | %{$_.contains(("X"))}) -contains $true) {
    
        $z=0
        :res_loop foreach ($res in $res_array){
            $res_char = $res.tochararray()
            :idx_loop foreach ($i in $x_idx) {
                #Write-Output $res_char
                if ($res_char[$i] -eq "X") {
                    #skriv 2 nye arrays til listen. En av dem overskiver den gamle X array'en
                    $ny_res_char = $res_char.Clone()
                    $ny_res_char[$i] = "0"
                    $ny_res1 = $(-join $ny_res_char)
                    $ny_res_char[$i] = "1"
                    $ny_res2 = $(-join $ny_res_char)

                    #Legg til listen
                    $res_array[$z] = $ny_res1
                    $res_array += $ny_res2
                    break res_loop

                }
            }
            $z++
        }
    }

    foreach ($res in $res_array) {
        $res_array_values += [Convert]::ToUInt64($res ,2)

    }

    # komma er vist viktig når man returnerer arrays fra funksjoner
    return ,$res_array_values

}

#region Les Input
$init_prog = Get-Content -Path ".\D14_Input\Input.txt"

#endregion Les Input

#region RegEx

[regex]$rx_minne = "(?<=\[)(\d+)(?=\])"
[regex]$rx_verdi = "(?<=\=\s)(\w+)"

#endregion RegEx

#region Memory allokering

$mem = @{}
#tis' all u need baby!

#endregion Memory



#region hoved loop

$tot_linjer = $init_prog.count
$linje_nr = 1

foreach ($Linje in $init_prog) {
    
    if ($Linje.contains("mask =")){
        $mask = $rx_verdi.Match($Linje).value

    } else {
        
        $mem_idx = [UInt64]$rx_minne.Match($Linje).value
        $value = [UInt64]$rx_verdi.Match($Linje).value

        [UInt64[]]$mem_idx_array = (MaskAdressDestinations $mask $mem_idx)

        foreach ($memID in $mem_idx_array) { 
           
            if (!($mem.ContainsKey($memID))) {
                # Jeg trodde først at man måtte konvertere veridene fortsatt i part 2, det måtte man ikke!
                #$mem.add($memID, $([UInt64](MaskConv $mask $value)))
                $mem.add($memID, $value)
            } else {
                
                #$mem[$memID] = $([UInt64](MaskConv $mask $value))
                $mem[$memID] = $value
            }
        }  
    }
    Write-Host "Kalkulerer $linje_nr av $tot_linjer - $([math]::Round($linje_nr/$tot_linjer*100,1)) %" -f Cyan
    $linje_nr++
}

Write-Host "Svar: $(($mem.Values | measure -Sum).Sum)" -f Magenta

#endregion hoved loop