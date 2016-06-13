require 'dotenv'
Dotenv.load
require 'rest-client'
require_relative 'mailgun/params'
require_relative 'mailgun/sent_emails'
require_relative 'mailgun/send_email'
require_relative 'mailgun/suppressed_email'

module Mailgun
end