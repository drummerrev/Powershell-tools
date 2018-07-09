
$Date = (get-date -Format filedate)

Get-ADUser -Filter * -SearchBase "OU=Users,OU=WPPK1,OU=Sites,DC=corp,DC=warbyparker,DC=com" -Properties name,samaccountname,mail,givenName,surname,distinguishedname | 
 Select-Object name,samaccountname,mail,givenName,surname,distinguishedname | Export-Csv C:\output\CorpUsers-$Date.csv

Get-ADUser -Filter * -SearchBase "OU=Users,OU=WPRetail,OU=Sites,DC=corp,DC=warbyparker,DC=com" -Properties name,samaccountname,mail,givenName,surname,distinguishedname | 
 Select-Object name,samaccountname,mail,givenName,surname,distinguishedname | Export-Csv C:\output\RetailUsers-$Date.csv

Get-ADUser -Filter * -SearchBase "OU=WPlab,OU=Sites,DC=corp,DC=warbyparker,DC=com" -Properties name,samaccountname,mail,givenName,surname,distinguishedname | 
 Select-Object name,samaccountname,mail,givenName,surname,distinguishedname | Export-Csv C:\output\LabUsers-$Date.csv



$ADCorp = Import-Csv C:\output\CorpUsers-$Date.csv
$ADRetail = import-csv C:\output\RetailUsers-$Date.csv
$ADLab = import-csv C:\output\LabUsers-$Date.csv

$GoogleUsersCorp = import-csv C:\output\GoogleUsersCorp-$Date.csv
$GoogleUsersRetail = import-csv C:\output\GoogleUsersRetail-$Date.csv
$GoogleUsersLab = Import-Csv C:\output\GoogleUsersLab-$Date.csv

Compare-Object $ADCorp $GoogleUsersCorp -Property mail -IncludeEqual | Out-File C:\output\GoogleADCorpComps-$Date.txt
Compare-Object $ADRetail $GoogleUsersRetail -Property mail -IncludeEqual | Out-File C:\output\GoogleADRetailComps-$Date.txt
Compare-Object $ADLab $GoogleUsersLab -Property mail -IncludeEqual | Out-File C:\output\GoogleADLabComps-$Date.txt