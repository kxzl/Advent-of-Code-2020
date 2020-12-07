$MinListe = Get-Content -Path ".\D7_Input\Input.txt"
#$MinListe = Get-Content -Path ".\D7_Input\test.txt"

function FinnBagSomInneholder($MinListe, $BagNavn) {

    [regex]$rx_mainbag = ".*(?=\sbags\scontain\s)"
    [regex]$bag_content = "(?<=\sbags\scontain\s).*"
    [regex]$rx_antall = "\d+"
    [array]$NewBagNavnArray = @()
    [array]$NewMinListe = @()
    [array]$resultat = @()
    
    foreach ($Line in $MinListe) {
    
        $Bag = $rx_mainbag.Match($Line).Value
        $content =  $bag_content.Match($Line).Value
        
        if ($content.Contains($BagNavn)) {
            $NewBagNavnArray += $Bag
        }
        
    }

    if ($NewBagNavnArray.Length -eq 0) {
        $resultat += $BagNavn
    } else {
        foreach ($Innhold in $NewBagNavnArray) {
            $resultat += $Innhold
            $resultat += FinnBagSomInneholder $MinListe $Innhold
        }
    }

    return $resultat

}

$minbag = "shiny gold"
$test = FinnBagSomInneholder $MinListe $minbag
#Write-Output ($test | sort | Get-Unique)
Write-Output $(($test | sort | Get-Unique).count)

