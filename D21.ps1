$MinListe = Get-Content -Path "C:\Users\roman\OneDrive\Desktop\AoC\d_2\Input.txt" 

#[string]$Linje = $MinListe[0]

[regex]$rx = "(?<Min>\S+)-(?<Max>\S+) (?<bokst>.+)\: (?<pass>.*)"

[int]$Antall = 0
foreach ( $Linje in $MinListe ) {
    
    $res = $rx.Match($Linje)

    [int]$Min = $res.Groups["Min"].Value
    [int]$Max = $res.Groups["Max"].Value
    [string]$Bokstav = $res.Groups["bokst"].Value
    
    [string]$pwd = $res.Groups["pass"].Value

    [int]$charCount = ($pwd.ToCharArray() | Where-Object {$_ -eq $Bokstav} | Measure-Object).Count
    
    if ( ($charCount -le $Max) -and ($charCount -ge $Min) ) {
        $Antall = $Antall + 1
    }
}

Write-Output $Antall