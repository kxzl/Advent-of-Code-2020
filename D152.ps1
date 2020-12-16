

$startTall = @(6,13,1,15,2,0)

#region variabler

$oversikt = @{}
$target = 30000000
$tall = 0
$sist_Sagt = 0

#endregion variabler

#region populer loop

for ($i=0; $i -lt $startTall.Count-1; $i++) {
    
    
    $oversikt.Add($startTall[$i], @($($i+1),$($i+1)))
    

}

$tall = $startTall[-1]

#endregion populer loop

#region main loop

# Oversikt er en hashtabell
# oversikt[$tall] gir et array av sist sette verdier for tallet
# oversikt[$tall][0] er verdien sist sett
# oversikt[$tall][1] er verdien sist sett før "sist sett"

for ($z=$i+1; $z -lt $target; $z++) {
    
    if ($oversikt.ContainsKey($tall)) {
        $oversikt[$tall][1] = $oversikt[$tall][0]
        $oversikt[$tall][0] = $z
        $sist_Sagt = $($oversikt[$tall][0]-$oversikt[$tall][1])
        $tall = $sist_Sagt
    } else {
        $oversikt.Add($tall, @($z,$z))
        $tall = 0
    }

    #Write-Host "Nytt Tall: $tall" -f Magenta

}

Write-Host "Tur: $($z) - Tall: $tall" -f Cyan

#endregion main loop