[string[]]$Bevegelse = Get-Content -Path ".\D12_input\Input.txt"

# Skipet starter med nesen mot "east"

#i radianer. IF settingen under konverterer tallene fra grader til radianer
[int]$heading = 0

#horisontal
[int]$pos_x = 0
#vertikal
[int]$pos_y = 0

[regex]$rx_tall = "\d+"

foreach ($Linje in $Bevegelse) {
    
    $tall = ($rx_tall.Match($Linje)).Value

    if ($Linje[0] -eq "N") {
        $pos_y = $pos_y + $tall
    } elseif ($Linje[0] -eq "S") { 
        $pos_y = $pos_y - $tall
    } elseif ($Linje[0] -eq "E") {
        $pos_x = $pos_x + $tall
    } elseif ($Linje[0] -eq "W") {
        $pos_x = $pos_x - $tall
    } elseif ($Linje[0] -eq "L") {
        $heading = ($heading + $tall)%360

       
    } elseif ($Linje[0] -eq "R") {
        $heading = ($heading + (360-$tall))%360
        
    } elseif ($Linje[0] -eq "F") {
        $pos_x = $pos_x + [int][Math]::Cos($heading*[Math]::PI/180)*$tall
        $pos_y = $pos_y + [int][Math]::Sin($heading*[Math]::PI/180)*$tall
    }
    #Write-Output "---------"    
    #Write-Output "x: $pos_x"
    #Write-Output "y: $pos_y"

}

Write-Output "x: $pos_x"
Write-Output "y: $pos_y"
Write-Output "Manhatten lengde: $([Math]::Abs($pos_x)+[Math]::Abs($pos_y))"