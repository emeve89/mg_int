require 'spec_helper'
require_relative '../../mailgun/params'

describe Mailgun::EmailParams do
  let(:from) { 'from@test.com' }
  let(:to) { 'to@test.com' }
  let(:subject) { 'subject' }
  let(:text) { 'text' }
  let(:'o:campaign') { 'campaign-id' }
  let(:klass) { Mailgun::EmailParams.new(from, to, subject, text, send(:'o:campaign')) }

  %w(from to subject text o:campaign).each do |field|
    it "sets #{field}" do
      expect(klass.send(field.to_sym)).to eq send("#{field}")
    end
  end

  describe '#to_h' do
    let(:expected_hash) do
      {
          from: from,
          to: to,
          subject: subject,
          text: text,
          'o:campaign': send(:'o:campaign')
      }
    end

    it 'returns a hash with the attributes' do
      expect(klass.to_h).to eq expected_hash
    end
  end
end