# Instantiate and start a new stopwatch
$stopwatch = [System.Diagnostics.Stopwatch]::StartNew()

function FinnNaboer ($cube) {

    [int]$x, [int]$y, [int]$z = $cube.Split("_")
    $neighbors = @()

    for ($d_x=-1; $d_x -le 1; $d_x++) {
        for ($d_y=-1; $d_y -le 1; $d_y++) {
            for ($d_z=-1; $d_z -le 1; $d_z++) {

                if (!(($d_x -eq 0) -and ($d_y -eq 0) -and ($d_z -eq 0))) {
                    $neighbors += "$($x+$d_x)" + "_" + "$($y+$d_y)" + "_" + "$($z+$d_z)"
                }
            }
        }
    }

    return $neighbors

}

function SokOmraade ($conway_space) {

    $x_min = 0
    $x_max = 0

    $y_min = 0
    $y_max = 0

    $z_min = 0
    $z_max = 0

    foreach ($koor in $conway_space.Keys) {
        [int]$x, [int]$y, [int]$z = $koor.Split("_")

        # X
        if ($x -lt $x_min) {
            $x_min = $x
        }

        if ($x -gt $x_max) {
            $x_max = $x
        }

            # Y
        if ($y -lt $y_min) {
            $y_min = $y
        }

        if ($y -gt $y_max) {
            $y_max = $y
        }

            # Z
        if ($z -lt $z_min) {
            $z_min = $z
        }

        if ($z -gt $z_max) {
            $z_max = $z
        }
    }

    $x_min = $x_min - 1
    $x_max = $x_max + 1

    $y_min = $y_min - 1 
    $y_max = $y_max + 1 

    $z_min = $z_min - 1
    $z_max = $z_max + 1

    $search_space = @()

    for ($d_x=$x_min; $d_x -le $x_max; $d_x++) {
        for ($d_y=$y_min; $d_y -le $y_max; $d_y++) {
            for ($d_z=$z_min; $d_z -le $z_max; $d_z++) {

                $search_space += "$d_x" + "_" + "$d_y" + "_" + "$d_z"

            }
        }
    }

    return $search_space

}

$init_state = Get-Content -Path ".\D17_Input\Input.txt"


$y_width = $init_state.Length
$x_width = $init_state[0].Length
$conway_space = @{}


#initialize conway_space
for ($i=0; $i -lt $y_width; $i++) {

    for ($q=0; $q -lt $x_width; $q++) {
        if ($init_state[$i][$q] -eq "#") {
            $coor_string = "$q" + "_" + "$i" + "_0"
            $conway_space.Add($coor_string, $init_state[$i][$q])
        }

    }
}



$new_conway_space = $conway_space.Clone()
$cycle = 0

while ($cycle -lt 6) {

    
    $omraade = SokOmraade $conway_space
    foreach ($cube in $omraade) {
        $counter = 0
        $naboer = FinnNaboer $cube
        
        # tell aktive naboer og legg til naboene til conway space listen om dem ikke finnes der fra før
        foreach ($nabo in $naboer) {
    
            if ($conway_space.ContainsKey($nabo)) {
                # tell naboen om naboen er aktiv
                $counter++
            }
    
        }
    
        if (($conway_space.$cube -eq "#") -and (($counter -eq 2) -or ($counter -eq 3))) {
            # ikke gjør noe, kuben forblir aktiv
        } elseif (($conway_space.$cube -eq $null) -and ($counter -eq 3)) {
            $new_conway_space.$cube = "#"
        } else {
            $new_conway_space.Remove($cube)
        }

    }

    $conway_space = $new_conway_space.Clone()
    $cycle++
    Write-Host "Cycle: $cycle"

}

Write-Host "-----------" -f Red
Write-Host "Cycle: $cycle - Svar: $($conway_space.Count)" -f Magenta
Write-Host "Dette tok: $($stopwatch.Elapsed.Seconds) sek" -f Cyan

