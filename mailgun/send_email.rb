module Mailgun
  class SendEmail
    BASE_URL = "https://api:#{ENV['MAILGUN_API_KEY']}@api.mailgun.net/v3/#{ENV['MAILGUN_DOMAIN']}"
    MESSAGES_ENDPOINT = "#{BASE_URL}/messages".freeze

    def call(email_params)
      RestClient.post(MESSAGES_ENDPOINT, email_params.to_h)
    end
  end
end