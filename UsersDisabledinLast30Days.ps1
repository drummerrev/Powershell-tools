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
# 
#  

$31Days = (get-date).adddays(-31)

Search-ADAccount -UsersOnly -AccountDisabled -SearchBase "OU=Disabled Users,DC=,DC=,DC=com" |
sort LastLogonDate | Select Name,LastLogonDate,DistinguishedName | 
out-gridview -title "Disabled Employees" |
Export-Csv "C:\Users\username\DisabledAccountsinLast30Days.csv" -encoding "unicode"
