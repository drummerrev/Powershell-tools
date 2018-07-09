Set-ADUser GlenJohn -Remove @{otherMailbox="glen.john"} -Add @{url="fabrikam.com"} -Replace @{title="manager"} -Clear description
    