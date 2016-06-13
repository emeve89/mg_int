module Mailgun
  #
  # This class checks if a given email is listed
  # in one of the suppression lists.
  #
  class SuppressedEmail
    BASE_URL = "https://api:#{ENV['MAILGUN_API_KEY']}@api.mailgun.net/v3/#{ENV['MAILGUN_DOMAIN']}".freeze
    BOUNCE_ENDPOINT = "#{BASE_URL}/bounces/".freeze
    UNSUBSCRIBE_ENDPOINT = "#{BASE_URL}/unsubscribes/".freeze
    COMPLAINTS_ENDPOINT = "#{BASE_URL}/complaints/".freeze

    attr_reader :email

    def initialize(email)
      @email = email
    end

    def call
      {
        suppressed: suppressed?,
        status: set_status
      }
    end

    private

    def suppressed?
      bounced? || unsubscribed? || complaint?
    end

    def bounced?
      RestClient.get(BOUNCE_ENDPOINT.concat(email)) do |response, _, _|
        response.code.equal?(200)
      end
    end

    def unsubscribed?
      RestClient.get(UNSUBSCRIBE_ENDPOINT.concat(email)) do |response, _, _|
        response.code.equal?(200)
      end
    end

    def complaint?
      RestClient.get(COMPLAINTS_ENDPOINT.concat(email)) do |response, _, _|
        response.code.equal?(200)
      end
    end

    def set_status
      return 'bounced' if bounced?
      return 'unsubscribed' if unsubscribed?
      return 'complaint' if complaint?
    end
  end
end
