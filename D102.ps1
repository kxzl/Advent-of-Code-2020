


function DeriveList($MinListe) {

    #$diff1 = 0
    #$diff2 = 0
    #$diff3 = 0
    #$sum = 0


    $MinListe = $MinListe | Sort-Object {[int]$_}
    #$MinListe = 0, $MinListe

    for ($i=0; $i -le $MinListe.count; $i++) {
        if(($MinListe[$i] - $MinListe[$i+1]) -eq -1) {
            Write-Output ($MinListe[$i+1] - $MinListe[$i])
            $sum = $sum + ($MinListe[$i+1] - $MinListe[$i])
            $diff1++
        }elseif(($MinListe[$i] - $MinListe[$i+1]) -eq -2) {
            Write-Output ($MinListe[$i+1] - $MinListe[$i])
            $sum = $sum + ($MinListe[$i+1] - $MinListe[$i])
            $diff2++ 
        }elseif(($MinListe[$i] - $MinListe[$i+1]) -eq -3) {
            Write-Output ($MinListe[$i+1] - $MinListe[$i])
            $sum = $sum + ($MinListe[$i+1] - $MinListe[$i])
            $diff3++
        } #else {
            #[int]$q = ($MinListe[$i])
            #Write-Output "Adapter: $($q+3))"
        #}

    }
}


$MinListe = Get-Content -Path ".\D10_Input\test.txt"
$MinListe += 0
$MinListe += (($MinListe | measure -Maximum).Maximum+3)
$d_array = DeriveList $MinListe

$c4 = 0
$c3 = 0
$c2 = 0

for ($z=0; $z -lt $d_array.count; $z++) {

    if ($d_array[$z] -ne 3) {
        $w = 0
        While (($d_array[$z+$w] -ne 3) -and (($z+$w) -lt $d_array.Count) ) {
            $w++        
        }

        if ($w -eq 4) {
            $c4++
        } elseif ($w -eq 3) {
            $c3++
        } elseif ($w -eq 2) {
            $c2++
        } else {
            Write-Output "w: $w"
        }

        $z = $z + $w
    }
}

Write-Output "4: $c4 3: $c3 2: $c2"
Write-Output "Svar: $([Math]::Pow(7,$c4)*[Math]::Pow(4,$c3)*[Math]::Pow(2,$c2))"



