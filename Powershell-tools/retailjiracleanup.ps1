#Sript Collects all members of DUO_Enable, filtered to Retail Users, then iterates through list and removes from DUO_Enable AD Group

Get-ADGroupMember jira-cx | Where-Object -FilterScript { $_.distinguishedName -like '*OU=WPRetail*' } |
 ForEach-Object -Process {
  Remove-ADPrincipalGroupMembership -Identity $_ -MemberOf jira-cx -Confirm:$false }