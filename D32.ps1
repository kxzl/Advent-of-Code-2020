$MinListe = Get-Content -Path "C:\Users\roman\OneDrive\Desktop\AoC\D3_Input\Input.txt"
#$MinListe = Get-Content -Path "C:\Users\roman\OneDrive\Desktop\AoC\D3_Input\test.txt"

$Grid_w = $($MinListe[0].ToCharArray()).Length



$MultiFactor = 1

$x_array = 1, 3, 5, 7, 1
$y_array = 1, 1, 1, 1, 2

for ($z = 0; $z -lt $x_array.Length; $z++) {
    $TreeCount = 0
    $x = 0
    $x_move = $x_array[$z]
    $y_move = $y_array[$z]
    

    for ($y=$y_move; $y -le $MinListe.Length-1; $y = $y+$y_move ) {
        $x = (($x + $x_move) % ($Grid_w))

        $Tegn = $($MinListe[$y].ToCharArray())[$x]

        if ( $Tegn -eq "#") {
            $TreeCount = $TreeCount + 1
        }

    }
    
    $MultiFactor = $MultiFactor * $TreeCount
    Write-Output "--------"
    Write-Output $TreeCount
    #Write-Output "$z of $($x_array.Length)"

}

Write-Output "##############"
Write-Output "Multi: $MultiFactor"