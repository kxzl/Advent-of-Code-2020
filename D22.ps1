$MinListe = Get-Content -Path "C:\Users\roman\OneDrive\Desktop\AoC\d_2\Input.txt" 

#[string]$Linje = $MinListe[15]

[regex]$rx = "(?<Min>\S+)-(?<Max>\S+) (?<bokst>.+)\: (?<pass>.*)"

[int]$Antall = 0
foreach ( $Linje in $MinListe ) {
    
    $Sum = 0
    $res = $rx.Match($Linje)

    [int]$Min = $res.Groups["Min"].Value
    [int]$Max = $res.Groups["Max"].Value
    [string]$Bokstav = $res.Groups["bokst"].Value
    
    [string]$pwd = $res.Groups["pass"].Value
    $pwd_array = $pwd.ToCharArray()

    $test1 = ($pwd_array[$Min-1] -eq $Bokstav)
    $test2 = ($pwd_array[$Max-1] -eq $Bokstav)
    $Sum =  $test1+$test2

    #Write-Output "--------------------"
    #Write-Output "Bokstav - $Bokstav"
    #Write-Output "Min $($Min+1) - $($pwd_array[$Min+1])"
    #Write-Output "Max $($Max+1) - $($pwd_array[$Max+1])"
    #Write-Output "Test pass: $($Sum -eq 1)"

    if ($Sum -eq 1) {
        $Antall = $Antall + 1
    } 
    
}

Write-Output $Antall