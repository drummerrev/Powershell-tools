# Export Active AD Accounts (email address, first name, last name) to CSV in c:\output

Get-ADUser -Filter {enabled -eq $true} -Properties mail,givenName,sn | Select -Property mail,givenName,sn | Export-Csv C:\output\ADUsers.csv