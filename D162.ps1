
$bilett_input = Get-Content -Path ".\D16_Input\Input.txt" -Raw



# Finn beskrivelsene for betingelser og billettene og split input på dette
# lager først en regex som matcher på alle ord med kolon og mellomrom

#region RegEx

[regex]$rx_headere="([^\d\n]+:)"
[regex]$rx_betingelse = "(\d+-\d+)"

#endregion RegEX

#region preprossesering av input

$input_split = [regex]::Split($bilett_input, $rx_headere)
#fjern tomme linjer om det er noen
$input_split = $input_split.Where({ $_ -ne ""})
#endregion 

#Mer hashtabeller!
$minoversikt = @{}

foreach ($line in $input_split) {

    if ($line -match $rx_headere) {
        $MinKey = $line
        $minoversikt.add($MinKey,@())
    } else {
        
        if ($line -match $rx_betingelse) {
            $betingelse = $rx_betingelse.Matches($line).value

            foreach ($b in $betingelse) {
                # om det er en betingelse så ignorerer vi alle "or" og kjører "eval" funksjon rett på strengen for å lage tall arrays.
                $minoversikt.$MinKey += @($(Invoke-Expression $b.Replace("-","..")))
            }

        } else {
            #om det ikke er en betingelse så er det en billett, da spliter man strengen på komma for å få alle tallene.
            $minoversikt.$MinKey += $line.Replace("`n","").Replace(","," ").split("`r").Where({ $_ -ne ""})
        }

    }

}

#region sjekk betingelsene

$felt_oversikt = @{}
:outer foreach ($billett in $minoversikt.'nearby tickets:') {
    $tall_array = $billett.Split(" ")
    for ($i=0; $i -lt $tall_array.Count; $i++) {
        $tall = $tall_array[$i]
        :inner foreach ($key in $minoversikt.Keys) {
    
            if (!($key).contains("ticket")) {
            #Write-Host $key -f Magenta
            #Write-Host "$key Inneholder $tall - $($minoversikt.$key.Contains($tall))"
            # fikk en bug sånn at ting ikke slo ut som true når dem burde. Eksplisit sette type ser ut til å fungere
            $bet = [string[]]$minoversikt.$key
                if($bet.Contains([string]$tall)) {
                    #Write-Host "True!" -f Red
                    if (!($felt_oversikt.ContainsKey($i))) {
                        $felt_oversikt.Add($i,@($key))
                    } else {
                        $felt_oversikt.$i += $key
                    }
                    #break inner
                }
            }
        
        }

    }
}

#endregion


[array]$key_list = @()
$ny_felt_oversikt = $felt_oversikt.Clone()

$svar = @{}
$svar_out = 1

:outer while ($felt_oversikt.Keys.Count -ne $key_list.Count) {
    :inner foreach ($key in $felt_oversikt.Keys) { 

        if(!($key_list.Contains($key))) {
            $telling = $felt_oversikt.$key | Group-Object | Select-Object Name,Count | Sort-Object -Property Count -Descending
            if ($telling[0].Count -gt $telling[1].Count) {
                
                Write-Host "$key er felt: $($telling[0].Name) $($($minoversikt.'your ticket:').Split(" ")[$key])"
                $svar.Add($($telling[0].Name), $key)

                if ($($telling[0].Name).Contains("departure")) {
                    $svar_out = $svar_out*[int]$($($minoversikt.'your ticket:').Split(" ")[$key])
                }


                foreach ($key1 in $felt_oversikt.Keys) {
                    #break outer
                    $ny_felt_oversikt.$key1 = $felt_oversikt.$key1 | Where-Object { $_ –ne [string]$($telling[0].Name) }
                }
                $key_list +=$key
                $felt_oversikt = $ny_felt_oversikt.Clone()
                break inner
            }
        }

    }

}

Write-Host "Svar: $svar_out" -f Magenta