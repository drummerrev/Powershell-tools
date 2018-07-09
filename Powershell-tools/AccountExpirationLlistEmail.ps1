Search-ADAccount -AccountExpiring -TimeSpan "10" | 
Export-Csv "C:\Users\jeremy.long\AccountExpiringwithin10Days.csv" -encoding "unicode"
Send-MailMessage -To "jeremy.long <jeremy.long@warbyparker.com>" -Cc "jeremy.long <jeremy.long@warbyparker.com>" -From "WP AD Reporting <tech@warbyparker.com>" `
 -Subject "Expiring Accounts" `
 -Body "The attached CSV file contains the Warby Parker Active Directory accounts that are set to expire within 10 Days.  
      These are Temp Hire/Intern accounts that will be automatically disabled in AD once the Expiry date has been reached.  
	  Please reach out to acting Managers to verify account status." `
 -Attachments "c:\Users\jeremy.long\AccountExpiringwithin10Days.csv" -SmtpServer smtp.warby.io