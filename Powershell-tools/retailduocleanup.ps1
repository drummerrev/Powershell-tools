#Sript Collects all members of DUO_Enable, filtered to Retail Users, then iterates through list and removes from DUO_Enable AD Group

Get-ADGroupMember DUO_Enable | Where-Object -FilterScript { $_.distinguishedName -like '*OU=WPRetail*' } |
 ForEach-Object -Process {
  Remove-ADPrincipalGroupMembership -Identity $_ -MemberOf DUO_Enable -Confirm:$false }