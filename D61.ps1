$MinListe = Get-Content -Path "C:\Users\roman\OneDrive\Desktop\AoC\D6_Input\Input.txt" -Raw 
#$MinListe = Get-Content -Path "C:\Users\roman\OneDrive\Desktop\AoC\D6_Input\test.txt" -Raw 

$nl = [System.Environment]::NewLine
$GruppeListe = ($MinListe -split "$nl$nl") | Foreach {$_ -replace "`r`n",' '}

$Sum = 0
foreach ($Gruppe in $GruppeListe) {

    $Gruppe = $Gruppe -replace "\W"
    $Sum = $Sum + $(($Gruppe.ToCharArray() | Sort | Get-Unique)).Count
    #Write-Output $(($Gruppe.ToCharArray() | Sort | Get-Unique)).Count
}

Write-Output $Sum