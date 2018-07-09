# Simple script to identify AD accounts created in the last 'x' amount of days and 
# sends an email report to relevant AD Account Auditors

$When = ((Get-Date).AddDays(-7)).Date
Get-ADUser -Property Name,mail,whenCreated,LastLogonDate,Modified,DistinguishedName -Filter {whenCreated -ge $When} |
sort whenCreated | Select -Property Name,mail,whenCreated,LastLogonDate,Modified,DistinguishedName | 
# out-gridview -title "Recently Created Accounts" <--- for debugging and stdout results display
Export-Csv "C:\Users\username\RecentlyCreatedAccounts.csv" -encoding "unicode"

#Sends Email of results to designated Account auditors

Send-MailMessage -To "username <email address>" -Cc "username <jemail address>" -From "WP AD Reporting <email address>" `
 -Subject "AD Accounts Created in Last Week" `
 -Body "The attached CSV file contains the Warby Parker Active Directory accounts that were created within the last 7 days.  
      The report includes last Modification date and last Logon date as well for account auditing purposes." `
 -Attachments "c:\Users\username\RecentlyCreatedAccounts.csv" -SmtpServer smtp.server.name
