



function MaskConv ($mask, $value) {
    
    $value_bin = (([Convert]::ToString($value,2)).PadLeft(36,"0")).ToCharArray()
    $value_bin_new = [char[]]::new(36)
    for ($i=35; $i -ge 0;$i--){
        if ($mask[$i] -ne "X"){
            $value_bin_new[$i] = $mask[$i]
        } else {
            $value_bin_new[$i] = $value_bin[$i]
        }
    
    } 

    $value_new = [Convert]::ToInt64($(-join $value_bin_new) ,2)

    Write-Output $value_new

}

#region Les Input
$init_prog = Get-Content -Path ".\D14_Input\Input.txt"

#endregion Les Input

#region RegEx

[regex]$rx_minne = "(?<=\[)(\d+)(?=\])"
[regex]$rx_verdi = "(?<=\=\s)(\w+)"

#endregion RegEx

#region Memory allokering
## finn største minne plasseringen og alokaliser minne til det

$mem_array = @()
foreach ($Line in $init_prog) {
    
    if ($Line.contains("mem")) {

        $mem_array += $rx_minne.Match($Line).value    
    
    }
}

$memMax = ($mem_array | measure -Maximum).Maximum
$mem = [Int64[]]::new($memMax+1)

#endregion Memory







foreach ($Linje in $init_prog) {
    
    if ($Linje.contains("mask")){
        $mask = $rx_verdi.Match($Linje).value  
    } else {
        $mem_idx = $rx_minne.Match($Linje).value
        $value = $rx_verdi.Match($Linje).value

        $mem[$mem_idx] = (MaskConv $mask $value)
    }
}

Write-Host "Svar; $(($mem | measure -Sum).Sum)" -f DarkGreen