[string[]]$Bussliste = Get-Content -Path ".\D13_Input\Input.txt"


[int]$NaaTid = $Bussliste[0]
$Busser = ($Bussliste[1]).Replace(",x","").split(",")

$NesteMuligeAvgang = @()
foreach($Buss in $Busser) {
    
    #Regn ut antall avganger som har gått frem til nå. Dropper desimaler
    $AntallAvganger = [Math]::Floor($NaaTid/$Buss)
    $SistAvgang = $AntallAvganger*$Buss
    $NesteMuligeAvgang += ($SistAvgang+$Buss)

    #Write-Output "-----------"
    #Write-Output "Buss: $Buss"
    #Write-Output "Sist Avgang: $SistAvgang"
    #Write-Output "Neste Avgang"
    

}


$TidligsteTidspunkt = ($NesteMuligeAvgang | measure -Minimum).Minimum
$idx = (0..($NesteMuligeAvgang.Count-1)) | where {$NesteMuligeAvgang[$_] -eq $TidligsteTidspunkt}

$Svar = ($TidligsteTidspunkt-$NaaTid)*$Busser[$idx]

Write-Output "Tidligste buss: $TidligsteTidspunkt"
Write-Output "Svar: $Svar "