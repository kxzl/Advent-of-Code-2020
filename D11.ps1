$MinListe = Get-Content -Path "C:\Users\roman\OneDrive\Desktop\AoC\d_1\Input.txt" 


for ($i=0; $i -le $MinListe.Length; $i++) {
    
  for ($z=$i+1; $z -le $MinListe.Length; $z++) {  
    
    [int]$n1 = $MinListe[$i]
    [int]$n2 = $MinListe[$z]

    if (($n1+$n2) -eq "2020") {
        Write-Output "i variabel: $n1"
        Write-Output "z variabel: $n2"
        Write-Output "Sum:" $n1+$n2
        $n3 = $n1*$n2
        Write-Output "Mult:" $n3
    }
  
  }

}