#$MinListe = Get-Content -Path ".\D7_Input\Input.txt"
$MinListe = Get-Content -Path ".\D7_Input\test.txt"

function FinnBagSomInneholder($MinListe, $BagNavn, [int]$numBags) {

    [regex]$rx_mainbag = ".*(?=\sbags\scontain\s)"
    [regex]$bag_content = "(?<=\sbags\scontain\s).*"
    [regex]$rx_antall = "\d+"
    [array]$NewBagNavnArray = @()
    [array]$NewMinListe = @()
    [array]$resultat = @()
    
    foreach ($Line in $MinListe) {
    
        $Bag = $rx_mainbag.Match($Line).Value
        $content =  $bag_content.Match($Line).Value

        
        if ($Bag -eq $BagNavn) {
            $NewBagNavnArray += $Bag
            $splitContent = $content.Split(",")
            foreach ($bagUnit in $splitContent) {
                $numBags += $rx_antall.Match($bagUnit).Value
            }
        }
        
    }

    if ($NewBagNavnArray.Length -eq 0) {
        $resultat = $numBags
    } else {
        foreach ($Innhold in $NewBagNavnArray) {
            $resultat = $numBags
            $resultat = FinnBagSomInneholder $MinListe $Innhold $numBags
        }
    }

    return $resultat

}

$minbag = "shiny gold"
[int]$numBags = 0
$test = FinnBagSomInneholder $MinListe $minbag
#Write-Output ($test | sort | Get-Unique)
Write-Output "Part 2"
Write-Output $test