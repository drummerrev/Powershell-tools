$Test2 = import-csv C:\output\BatchAliases.csv
$Test2 | gm
foreach ($user in $Test2) {
Get-ADUser -Identity $user.sAMAccountName -Properties * |
select sAMAccountName,mail,otherMailbox }

# Import AD Module             
Import-Module ActiveDirectory            
            
# Import CSV into variable $userscsv            
#$userscsv = import-csv C:\output\TestAliases.csv            
$users = Import-Csv -Path C:\output\BatchAliases.csv            
# Loop through CSV and update users if the exist in CVS file            
            
foreach ($user in $users) {            
#Search in specified OU and Update existing attributes            
 Get-ADUser -Filter "SamAccountName -eq '$($user.samaccountname)'" -Properties * -SearchBase "OU=Sites,DC=corp,DC=warbyparker,DC=com" |            
  Set-ADUser -Add @{otherMailbox="$($user.otherMailbox)"}            
}