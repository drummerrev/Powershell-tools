<# 
By Allenage.com on 08/Jan/2017 
 
Run the Script On Active Directory to remove disabled users from All Groups and Set description what user was member of group if you have all the disable users in an OU. 
Just add -SearchBase "OU=disabled,DC=domain,DC=com" after  -filter 'enabled -eq $false' 
 
#> 

import-module activedirectory 

Search-ADAccount -AccountExpired -UsersOnly | Where-Object {$_.Enabled}| Disable-ADAccount

$users=get-aduser -filter 'enabled -eq $false' -Properties samaccountname,memberof  |select samaccountname, @{n=’MemberOf’; e= { ( $_.memberof | % { (Get-ADObject $_).Name }) -join “,” }}  
 
#set description 
Foreach ($user in $users) 
{ Set-ADUser $user.samaccountname -Description "Was a member of :- $($user.memberof)" 
# Remove From all the Groups 
Get-ADGroup -Filter {name -notlike "*domain users*"}  | Remove-ADGroupMember -Members $user.samaccountname -Confirm:$False  
 
} 
 
 
       
 $total = ($users).count  
 
 Write-Host "$total accounts have been processed..." -ForegroundColor Green