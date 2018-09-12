# Set variable for date 31 days ago

$31Days = (get-date).adddays(-31)

# Search within Disabled Users OU for User accounts ...
Search-ADAccount -UsersOnly -AccountDisabled -SearchBase "OU=Disabled Users,DC=,DC=,DC=com" |
sort LastLogonDate | Select Name,LastLogonDate,DistinguishedName | 
out-gridview -title "Disabled Employees" |
Export-Csv "C:\Users\username\DisabledAccountsinLast30Days.csv" -encoding "unicode"
