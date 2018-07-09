Search-ADAccount -AccountExpiring -TimeSpan "10" | 
Export-Csv "C:\Users\username\AccountExpiringwithin10Days.csv" -encoding "unicode"
Send-MailMessage -To "username <email address>" -Cc "username <email address>" -From "WP AD Reporting <email address>" `
 -Subject "Expiring Accounts" `
 -Body "The attached CSV file contains the Warby Parker Active Directory accounts that are set to expire within 10 Days.  
      These are Temp Hire/Intern accounts that will be automatically disabled in AD once the Expiry date has been reached.  
	  Please reach out to acting Managers to verify account status." `
 -Attachments "c:\Users\username\AccountExpiringwithin10Days.csv" -SmtpServer smtp.server.info
