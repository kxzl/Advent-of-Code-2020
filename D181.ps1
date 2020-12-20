#$lekse = Get-Content -Path ".\D18_Input\Input.txt"
#$ligning = $lekse[0]

function RegnUt ($min_ligning) {

    $arr = $min_ligning.Split(" ")
    while ($arr.Count -ne 1) {
 
        $res = $(Invoke-Expression $("$($arr[0])"+"$($arr[1])"+"$($arr[2])"))
    
        if ($arr.Count -gt 3) {
            $new_arr = @()
            $new_arr += $res
            foreach ($el in $arr[3..$($arr.Count)]) {$new_arr += $el}
            $arr = $new_arr.clone()             
        } else {
            $arr = @($res)
        }
    }

    return [string]$res

}

$lekse = Get-Content -Path ".\D18_Input\Input.txt"
#$ligning = $lekse[0]

$Svar = [uint64]0

foreach($ligning in $lekse) {

    [regex]$rx_i_parantes = "(?<=\()([^\(\)]+)(?=\))"
    [regex]$rx_erstatt_parantes = "\("+$rx_i_parantes+"\)"
    $res = 0

    while ($ligning.Contains("(")) {
        $i_parantes = $rx_i_parantes.Match($ligning).Value
        $ny_i_parantes = RegnUt $i_parantes
        $ligning = $rx_erstatt_parantes.Replace($ligning,$ny_i_parantes,1)
    }
    
    
    $res = RegnUt $ligning  
    $Svar = $Svar + [uint64]$res
    #Write-Host $res

}


Write-Host "Svar: $Svar"