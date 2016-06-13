require 'spec_helper'
require 'rest-client'
require_relative '../../mailgun/send_email'

describe Mailgun::SendEmail do
  it 'defines MESSAGES_ENDPOINT' do
    expect{Mailgun::SendEmail::MESSAGES_ENDPOINT}.to_not raise_error
  end

  describe '#call' do
    it 'sends an email using Mailgun API' do
      email_params = double('email_params', to_h: {})
      expect(RestClient).to receive(:post).with(Mailgun::SendEmail::MESSAGES_ENDPOINT, email_params.to_h)

      described_class.new.call(email_params)
    end
  end
end