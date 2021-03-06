module Mailgun
  #
  # This class sends an email using the Mailgun API interface
  #
  class SendEmail
    BASE_URL = "https://api:#{ENV['MAILGUN_API_KEY']}@api.mailgun.net/v3/#{ENV['MAILGUN_DOMAIN']}".freeze
    MESSAGES_ENDPOINT = "#{BASE_URL}/messages".freeze

    def call(email_params)
      RestClient.post(MESSAGES_ENDPOINT, email_params.to_h)
    end
  end
end
