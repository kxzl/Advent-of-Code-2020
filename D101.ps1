#$MinListe = Get-Content -Path ".\testD9.txt"
$MinListe = Get-Content -Path ".\InputD9.txt"

$diff1 = 1
$diff2 = 1
$diff3 = 1


$MinListe = $MinListe | Sort-Object {[int]$_}

for ($i=0; $i -le $MinListe.Length; $i++) {
    if(($MinListe[$i] - $MinListe[$i+1]) -eq -1) {
        $diff1++
    }elseif(($MinListe[$i] - $MinListe[$i+1]) -eq -2) {
        $diff2++ 
    }elseif(($MinListe[$i] - $MinListe[$i+1]) -eq -3) {
        $diff3++
    } else {
        [int]$q = ($MinListe[$i])
        Write-Output "Adapter: $($q+3))"
    }

}


Write-Output "1: $diff1"
Write-Output "2: $diff2"
Write-Output "3: $diff3"

Write-Output "Svar: $($diff1*$diff3)"
