Load module
===========
1. Go to the directory where the module is located
2. Run irb
3. Inside IRB, run
```
require_relative 'mailgun'
```

#Functionalities
##Send Email with Mailgun

1. Build a Mailgun::EmailParams object that contains all the necessary data
```
email_params = Mailgun::EmailParams.new('from@email.com', 'to@email.com', 'subject', 'text', 'campaign-id')
```
2. Instantiate a Mailgun::SendEmail object and call **call** on it with the email params.
```
Mailgun::SendEmail.new.call(email_params)
```

##Fetch sent emails

1. Instantiate a Mailgun::SentEmails object with an email address
```
sent_emails = Mailgun::SentEmails.new('test@email.com')
```
2. Call **call**
```
sent_emails.call
```

It will return an Array of Hashes. Each one contains data related to a message sent to that email address.

##Check if an email is suppressed

1. Instantiate a Mailgun::SuppressedEmail with a given email address
```
suppressed_email = Mailgun::SuppressedEmail.new('test@email.com')
```
2. Call **call**
```
suppressed_email.call
```

It returns a hash with two keys
```
{
  suppressed: ..., # True or false
  status: ... # bounced, unsubscribed, complaint or not_suppressed
}
```

#Specs
##Run
1. Go to the directory where the code is located.
2. Run
```
rake
```

#Environmet variables
The ENV variables are managed with dotenv.

1. Create a .evn file
2. Add the following variables
```
MAILGUN_API_KEY=...
MAILGUN_DOMAIN=...
```

