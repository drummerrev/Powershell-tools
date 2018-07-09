Set-ADAccountExpiration -DateTime:"07/07/2017 20:00:00" -Identity:"CN=First Last,OU=,OU=,OU=,DC=,DC=,DC=com"

Set-ADAccountExpiration -DateTime:"07/07/2017 00:00:00" first.last -Server:"AD.server.name"

#Another Alternative Pipeline treatment
Get-ADUser -filter {(samaccountname -like "jeremyz*")} | Set-ADAccountExpiration -DateTime:"08/11/2017 20:00:00" -Server:"AD.server.name"
