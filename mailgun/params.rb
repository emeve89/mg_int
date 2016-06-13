module Mailgun
  EmailParams = Struct.new(:from, :to, :subject, :text, :'o:campaign')
end