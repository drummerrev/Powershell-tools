#Import Active Directory module
Import-Module ActiveDirectory -Verbose:$false
 
#region: Define variables
#Get expired AD accounts that are not disabled
$ExpiredAccountsNotDisabled = Search-ADAccount -AccountExpired -Server:"server.name" | Where-Object { $_.Enabled -eq $true }
 
#Define OU for Disabled Accounts. Change to reflect your OU
$DisabledAccountsOU = 'OU=Disabled Users,DC=,DC=,DC=com'
 
#Get current date
$Date = Get-Date -Format g
#endregion

#Email Expired Accounts List to AD Account Auditors
Search-ADAccount -AccountExpired | Where-Object { $_.Enabled -eq $true } | Export-Csv "C:\WP_Scripts\ExpiredandDisabledToday.csv" -encoding "unicode"

Send-MailMessage -To "username <email address>" -Cc "username <email address>" -From "WP AD Reporting <email address>" `
 -Subject "Expired AD Accounts that are Now Disabled" `
 -Body "The attached CSV file contains the Warby Parker Active Directory accounts that expired today and were disabled by Daily Automation." `
 -Attachments "c:\WP_Scripts\ExpiredandDisabledToday.csv" -SmtpServer smtp.server.name

 
#Loop through Expired Users
ForEach($User in $ExpiredAccountsNotDisabled) {
  #Strip Group Membership except for 'Domain Users'
  Get-ADPrincipalGroupMembership -Identity $User | where {$_.Name -notlike "Domain Users"} | % {Remove-ADPrincipalGroupMembership -Identity $User -MemberOf $_ -Confirm:$false}

  #Add User to "Disabled_Users" AD Group
  Add-ADPrincipalGroupMembership -Identity $User -MemberOf Disabled_Users

  # Write Description & Disable Account
  Set-ADUser -Identity $User.SamAccountName -Description "Disabled $Date" -Enabled $false
  
  # Move user to OU for Disabled Accounts
  Get-ADUser -identity $User.SamAccountName -Server:"server.info" | Move-ADobject -targetpath $DisabledAccountsOU 
  }
 
