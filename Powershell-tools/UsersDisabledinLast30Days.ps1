# Get the Current Date  
#   
#$CurrentDate=GET-DATE  
#  
# Number of Days to check back.    
#   
#$NumberDays=31  
#  
# Organizational Unit to search  
#  
#$SearchBase='OU=Disabled Users,DC=corp,DC=warbyparker,DC=com'  
#  

$31Days = (get-date).adddays(-31)

Search-ADAccount -UsersOnly -AccountDisabled -SearchBase "OU=Disabled Users,DC=corp,DC=warbyparker,DC=com" |
sort LastLogonDate | Select Name,LastLogonDate,DistinguishedName | 
out-gridview -title "Disabled Employees" |
Export-Csv "C:\Users\jeremy.long\DisabledAccountsinLast30Days.csv" -encoding "unicode"