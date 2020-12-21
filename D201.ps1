
$liste = Get-Content -Path ".\D20_Input\Input.txt" -Raw

$nl = [System.Environment]::NewLine
$liste = $liste -split "$nl$nl"

$antall_tiles = $liste.Count

$rx_tile_nr = [regex]"\d{4}"

$tiles = @{}

foreach ($tile in $liste) {

    $split_arr = $tile.Split("`n")
    $tile_title = $rx_tile_nr.Match($split_arr[0]).Value

    # Topp
    $tiles.add($("t_"+$tile_title),($split_arr[1]).TrimStart().trimend())
    # Bunn
    $tiles.add($("b_"+$tile_title),($split_arr[10]).TrimStart().trimend())

    # Venstre
    $v = @()
    # Høyre
    $h = @()
    for ($i=1; $i -lt $split_arr.Count; $i++) {
        $v += $split_arr[$i][0]
        $h += $split_arr[$i][9]
    }

    $tiles.add($("v_"+$tile_title),($v -join ""))
    $tiles.add($("h_"+$tile_title),($h -join ""))
    
}


$funnet = @()


# finn matcher. Tar hensyn til rotasjon
foreach ($key1 in $tiles.keys) {
    
    $id1 = $rx_tile_nr.Match($key1).Value

    if (-not($funnet.Contains($key1))) {
        :inner foreach ($key2 in $tiles.keys) {
        
            $id2 = $rx_tile_nr.Match($key2).Value

            if ($id1 -ne $id2) {
        
                if ($tiles.$key1 -eq $tiles.$key2){
            
                    #Write-host "$key1 og $key2 MATCH!" -f Cyan
                    $funnet += $key1
                    $funnet += $key2
                    break inner
            
                }
        
            }

        }
    }
}

#finn matcher, tar hensyn til flip

foreach ($key1 in $tiles.keys) {
    
    $id1 = $rx_tile_nr.Match($key1).Value

    if (-not($funnet.Contains($key1))) {

        $str_a = $($tiles.$key1).ToCharArray()
        [array]::Reverse($str_a)
        $str = -join($str_a)

        :inner foreach ($key2 in $tiles.keys) {
        
            $id2 = $rx_tile_nr.Match($key2).Value

            if ($id1 -ne $id2) {
        
                if ($str -eq $tiles.$key2){
            
                    #Write-host "$key1 og $key2 MATCH!" -f Green
                    $funnet += $key1
                    $funnet += $key2
                    break inner
            
                }
        
            }

        }
    }
}


Write-Host "Funnet: $($funnet.count)" -f Red

# yttersider inneholer nå alle ytterkantene
$yttersider = [array]$tiles.Keys | Where {$funnet -notcontains $_} 

# fjern prefiksen for top, bunn, venstre og høyre.
$yttersider | %{ $yttersider[$yttersider.IndexOf($_)] = $_.SubString(2) }

$Yttertiler = ($yttersider | group | sort count -Descending)

$svar_liste = 1
foreach ($tile in $Yttertiler) {
    
    if ($tile.count -eq 2) {
        
        Write-Host "Tile: $($tile.Name)"
        $svar_liste = $svar_liste * [uint64]$($tile.Name)
    }

}

Write-Host "Svar: $svar_liste"