require 'spec_helper'
require_relative '../../mailgun/sent_emails'

describe Mailgun::SentEmails do
  it 'defines EVENTS_ENDPOINT' do
    expect{Mailgun::SentEmails::EVENTS_ENDPOINT}.to_not raise_error
  end

  describe '#call' do
    let(:email) { 'user@example.com' }
    let(:json_response) do
      "{
          \"items\": [
              {
                  \"tags\": [],
                  \"timestamp\": 1376325780.160809,
                  \"envelope\": {
                      \"sender\": \"me@samples.mailgun.org\",
                      \"transport\": \"\"
                  },
                  \"event\": \"accepted\",
                  \"campaigns\": [],
                  \"user-variables\": {},
                  \"flags\": {
                      \"is-authenticated\": true,
                      \"is-test-mode\": false
                  },
                  \"message\": {
                      \"headers\": {
                          \"to\": \"user@example.com\",
                          \"message-id\": \"20130812164300.28108.52546@samples.mailgun.org\",
                          \"from\": \"Excited User <me@samples.mailgun.org>\",
                          \"subject\": \"Hello\"
                      },
                      \"attachments\": [],
                      \"recipients\": [
                          \"user@example.com\"
                      ],
                      \"size\": 69
                  },
                  \"recipient\": \"user@example.com\",
                  \"method\": \"http\"
              }
          ],
          \"paging\": {
              \"next\":
                  \"https://api.mailgun.net/v3/samples.mailgun.org/events/W3siY...\",
              \"previous\":
                  \"https://api.mailgun.net/v3/samples.mailgun.org/events/Lkawm...\"
          }
      }"
    end

    it 'returns all emails sent to a given email' do
      allow(RestClient).to receive(:get).and_return(json_response)
      response = described_class.new(email).call
      expect(response).to be_a Array
      expect(response.map(&:class).uniq).to eq [Hash]
      expect(response.first['recipient']).to eq email
    end
  end
end