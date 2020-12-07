$MinListe = Get-Content -Path "C:\Users\roman\OneDrive\Desktop\AoC\d_1\Input.txt" 


for ($i=0; $i -le $MinListe.Length; $i++) {
    
  for ($z=$i+1; $z -le $MinListe.Length; $z++) {  
    
    for ($y=$z+1; $y -le $MinListe.Length; $y++) {
        [int]$n1 = $MinListe[$i]
        [int]$n2 = $MinListe[$z]
        [int]$n3 = $MinListe[$y]

        if (($n1+$n2+$n3) -eq "2020") {
            Write-Output "i variabel: $n1"
            Write-Output "z variabel: $n2"
            Write-Output "Sum:" $n1+$n2
            $n4 = $n1*$n2*$n3
            Write-Output "Mult:" $n4
        }

    }
  
  }

}