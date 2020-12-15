[string[]]$Bussliste = Get-Content -Path ".\D13_Input\Input.txt"

$TidStart = (Get-Date).Second
$Busser = ($Bussliste[1]).split(",")

$MaxRute = ($Bussliste[1].Replace(",x","").Split(",") | measure -Maximum).Maximum
$MinRute = ($Bussliste[1].Replace(",x","").Split(",") | measure -Minimum).Minimum
$Multiple = 1

$RuteBusser = @()
$Tidsoffset = @()
$StartIDX = @()

for ($i=0; $i -lt $Busser.Length; $i++) {

    $Buss = $Busser[$i]

    if ($Buss -eq "x") {
        continue
    }

    $RuteBusser += [int]$Buss
    $Tidsoffset += $i
    $StartIDX += [double]($MaxRute/$Buss)
    $Multiple = $Multiple*[int]$Buss
}



#Denne oppgaven gjor meg lei av livet, så vi bare "piper" den rett inn WolframAlpha for å bevare julefreden.
#Lag input streng for wolfram.

[string]$Wolfram_redd_meg_fra_dette_hevete = "solve "

for ($i = 0; $i -lt $RuteBusser.Count; $i++) {
    
    $Wolfram_redd_meg_fra_dette_hevete += "(t+$($Tidsoffset[$i]))%$($RuteBusser[$i])=0, "
}

#Formater alt dette til html vennlig sak som Wolfram-senpai liker
$Wolfram_redd_meg_fra_dette_hevete

#Kjør ut 
Write-Host "Copy-paste som om det skule være en norskstil:" -f Red
Write-Host $Wolfram_redd_meg_fra_dette_hevete -f Green

start "https://www.wolframalpha.com/input/"

