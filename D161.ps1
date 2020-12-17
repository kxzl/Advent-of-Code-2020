
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
            $minoversikt.$MinKey += $line.Replace("`n",",").Replace("`r","").split(",").Where({ $_ -ne ""})
        }

    }

}

#region sjekk betingelsene

$error_values = @()
:outer foreach ($tall in $minoversikt.'nearby tickets:') {
    
    $test = $true
    :inner foreach ($key in $minoversikt.Keys) {
    
        if (!($key).contains("ticket")) {
        #Write-Host $key -f Magenta
        #Write-Host "$key Inneholder $tall - $($minoversikt.$key.Contains($tall))"
        # fikk en bug sånn at ting ikke slo ut som true når dem burde. Eksplisit sette type ser ut til å fungere
        $bet = [string[]]$minoversikt.$key
            if($bet.Contains([string]$tall)) {
                #Write-Host "True!" -f Red
                $test=$false
                break inner
            }
        }
        
    }

    if ($test) {
        $error_values += $tall
        #Write-Host $tall
    }

}

#endregion

Write-Host "Error rate: $(($error_values | measure -sum).sum)"