module Mailgun
  class SuppressedEmail
    BASE_URL = "https://api:#{ENV['MAILGUN_API_KEY']}@api.mailgun.net/v3/#{ENV['MAILGUN_DOMAIN']}"
    BOUNCE_ENDPOINT = "#{BASE_URL}/bounces/"
    UNSUBSCRIBE_ENDPOINT = "#{BASE_URL}/unsubscribes/"
    COMPLAINTS_ENDPOINT = "#{BASE_URL}/complaints/"

    attr_reader :email

    def initialize(email)
      @email = email
    end

    def call
      {
          suppressed: (bounced? || unsubscribed? || complaint?),
          status: set_status
      }

    end

    private

    def bounced?
      RestClient.get(BOUNCE_ENDPOINT.concat(email)) {|response, _, _| response.code.equal?(200) }
    end

    def unsubscribed?
      RestClient.get(UNSUBSCRIBE_ENDPOINT.concat(email)) {|response, _, _| response.code.equal?(200) }
    end

    def complaint?
      RestClient.get(COMPLAINTS_ENDPOINT.concat(email)) {|response, _, _| response.code.equal?(200) }
    end

    def set_status
      return 'bounced' if bounced?
      return 'unsubscribed' if unsubscribed?
      return 'complaint' if complaint?
    end
  end
end