module Mailgun
  class SentEmails
    BASE_URL = "https://api:#{ENV['MAILGUN_API_KEY']}@api.mailgun.net/v3/#{ENV['MAILGUN_DOMAIN']}"
    EVENTS_ENDPOINT = "#{BASE_URL}/events".freeze

    def initialize(email)
      @email = email
    end

    def call
      fetch_messages_sent
    end

    private

    attr_reader :email

    def params
      {
          recipient: email,
          event: 'delivered',
          limit: 300
      }
    end

    def response
      RestClient.get(EVENTS_ENDPOINT, params: params)
    end

    def parsed_response
      JSON.parse(response)
    end

    def fetch_messages_sent
      parsed_response['items']
    end
  end
end