Set-ADAccountExpiration -DateTime:"07/07/2017 20:00:00" -Identity:"CN=First Last,OU=Users,OU=WPPK1,OU=Sites,DC=corp,DC=warbyparker,DC=com"

Set-ADAccountExpiration -DateTime:"07/07/2017 00:00:00" first.last -Server:"Nimbus-AD01.corp.warbyparker.com"

#Another Alternative Pipeline treatment
Get-ADUser -filter {(samaccountname -like "jeremyz*")} | Set-ADAccountExpiration -DateTime:"08/11/2017 20:00:00" -Server:"Nimbus-AD01.corp.warbyparker.com"
