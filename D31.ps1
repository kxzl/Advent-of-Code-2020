$MinListe = Get-Content -Path "C:\Users\roman\OneDrive\Desktop\AoC\D3_Input\Input.txt"

#$MinListe = Get-Content -Path "C:\Users\roman\OneDrive\Desktop\AoC\D3_Input\test.txt"

$Grid_w = $($MinListe[0].ToCharArray()).Length

$x = 0
#$y = 0

$x_move = 3
$y_move = 1

$TreeCount = 0


for ($y=1; $y -le $MinListe.Length-1; $y = $y+$y_move ) {
    $x = (($x + $x_move) % ($Grid_w))
    #$y = $y + $y_move

    $Tegn = $($MinListe[$y].ToCharArray())[$x]

    if ( $Tegn -eq "#") {
        $TreeCount = $TreeCount + 1
    }

    Write-Output "---------"
    Write-Output "x: $x"
    Write-Output "y: $y"
    Write-Output $Tegn
}
 
Write-Output "--------"
Write-Output $TreeCount