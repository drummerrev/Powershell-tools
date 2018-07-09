#Script Searches designated OU - Disabled Users - and returns accounts with last logon date within last 31 days
#Import-Module ActiveDirectory 

$OU = "OU=Disabled Users,DC=,DC=,DC=com"
$31Days = (Get-Date).AddDays(-31)
Get-ADUser -Property Name,mail,LastLogonDate,Modified,DistinguishedName -Filter {LastLogonDate -gt $31Days} -SearchBase $OU |
sort LastLogonDate | Select -Property Name,mail,LastLogonDate,Modified,DistinguishedName | 
#out-gridview -title "Disabled Employees" <--- for debugging and stdout results display
Export-Csv "C:\Users\username\DisabledAccountsinLast30Days.csv" -encoding "unicode"

#Sends Email of results to designated Account auditors

Send-MailMessage -To "username <email address>" -Cc "username <email address>" -From "WP AD Reporting <email address>" `
 -Subject "AD Accounts Disabled in Last Month" `
 -Body "The attached CSV file contains the Warby Parker Active Directory accounts that were disabled within the last 31 Days.  
      The report includes last Modification date as well for account deprovision auditing purposes." `
 -Attachments "c:\Users\username\DisabledAccountsinLast30Days.csv" -SmtpServer smtp.warby.io
