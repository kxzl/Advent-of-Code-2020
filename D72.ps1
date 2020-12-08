    #$MinListe = Get-Content -Path ".\D7_Input\test.txt"
    $MinListe = Get-Content -Path ".\D7_Input\Input.txt"
  
    [regex]$rx_mainbag = ".*(?=\sbags\scontain\s)"
    [regex]$bag_content = "(?<=\sbags\scontain\s).*"
    [regex]$rx_antall = "\d"
    [regex]$rx_sub_bag = "(?<=\d\s).*(?=\sbag)"

function FinnBagInnhold($BagNavn) {

    [int]$BagAntall = 0

    foreach ($Line in $MinListe) {
        $Bag = $rx_mainbag.Match($Line).Value
        $content =  $bag_content.Match($Line).Value

        if ($Bag -eq $BagNavn) {
            $splitContent = $content.Split(",")
            
            foreach ($bagUnit in $splitContent) {
                if ($bagUnit.contains("no other bags.")) {
                    $BagAntall = 0
                } else {
                    $subBag = $rx_sub_bag.Match($bagUnit).Value
                    $Bag_i_bag = $rx_antall.Match($bagUnit).Value -as [int]
                    $BagAntall = $BagAntall + $Bag_i_bag + ($Bag_i_bag * $(FinnBagInnhold $subBag))
                }

            }
        }
            
    }
    return $BagAntall
}




[string]$minbag = "shiny gold"

$test = FinnBagInnhold $minbag
Write-Output "Part 2"
Write-Output $test