require 'spec_helper'
require_relative '../../mailgun/suppressed_email'

describe Mailgun::SuppressedEmail do
  it 'defines BOUNCE_ENDPOINT' do
    expect{Mailgun::SuppressedEmail::BOUNCE_ENDPOINT}.to_not raise_error
  end
  it 'defines UNSUBSCRIBE_ENDPOINT' do
    expect{Mailgun::SuppressedEmail::UNSUBSCRIBE_ENDPOINT}.to_not raise_error
  end
  it 'defines COMPLAINTS_ENDPOINT' do
    expect{Mailgun::SuppressedEmail::COMPLAINTS_ENDPOINT}.to_not raise_error
  end

  let(:email) { 'test@email.com' }
  let(:klass) { described_class.new(email) }
  describe '#initialize' do
    it 'sets @email' do
      expect(klass.email).to eq email
    end
  end

  describe '#call' do
    context 'when the email is not suppressed' do
      let(:expected_response) do
        {
            suppressed: false,
            status: 'not_suppressed'
        }
      end
      it 'returns a proper response' do
        allow(klass).to receive(:bounced?).and_return(false)
        allow(klass).to receive(:unsubscribed?).and_return(false)
        allow(klass).to receive(:complaint?).and_return(false)
        expect(klass.call).to eq expected_response
      end
    end
    context 'when email is bounced' do
      let(:expected_response) do
        {
            suppressed: true,
            status: 'bounced'
        }
      end
      it 'returns a proper response' do
        allow(klass).to receive(:bounced?).and_return(true)
        allow(klass).to receive(:unsubscribed?).and_return(false)
        allow(klass).to receive(:complaint?).and_return(false)
        expect(klass.call).to eq expected_response
      end
    end

    context 'when email is unsubscribed' do
      let(:expected_response) do
        {
            suppressed: true,
            status: 'unsubscribed'
        }
      end
      it 'returns a proper response' do
        allow(klass).to receive(:bounced?).and_return(false)
        allow(klass).to receive(:unsubscribed?).and_return(true)
        allow(klass).to receive(:complaint?).and_return(false)
        expect(klass.call).to eq expected_response
      end
    end

    context 'when email is complaint' do
      let(:expected_response) do
        {
            suppressed: true,
            status: 'complaint'
        }
      end
      it 'returns a proper response' do
        allow(klass).to receive(:bounced?).and_return(false)
        allow(klass).to receive(:unsubscribed?).and_return(false)
        allow(klass).to receive(:complaint?).and_return(true)
        expect(klass.call).to eq expected_response
      end
    end
  end
end