#$MinListe = Get-Content -Path ".\D9_Input\test.txt"
$MinListe = Get-Content -Path ".\D9_Input\Input.txt"

$preamble = 25

:outer for ($i = $preamble; $i -lt $MinListe.Length; $i++) {

    $p_list = @()
    $p_list += $MinListe[($i-$preamble)..$i]
    [int]$tallet = $MinListe[$i]
    $check = $false

    :inner for ($z = 0; $z -lt $p_list.Length; $z++ ) {
        $subt = $tallet - $p_list[$z]
        if ($p_list.Contains($subt)) {
            $check = $true
            break inner
        }

    }

    if (!($check)) {
        break outer
    } 

}  


Write-Output "Taller er: $($MinListe[$i])"