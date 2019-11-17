require 'spec_helper'

describe Locomotive::Coal::Resources::Token do

  before { VCR.insert_cassette 'token', record: :new_episodes }
  after  { VCR.eject_cassette }

  let(:uri)         { nil }
  let(:credentials) { nil }
  let(:token)       { described_class.new(uri, credentials) }

  describe '#get' do

    subject { token.get }

    context 'uri not pointing to a Locomotive engine' do
        let(:uri) { URI('http://acme.example.local:3000') }
        let(:credentials) { TEST_API_CREDENTIALS }
        it { expect { subject }.to raise_error Locomotive::Coal::UnknownResourceError }
      end

    context 'valid uri' do
      let(:uri) { TEST_API_V3_URI }

      context 'email + password as credentials' do
        let(:credentials) { TEST_API_CREDENTIALS }
        it { is_expected.to match(/^[a-zA-Z0-9_-]{,20}$/) }
      end

      context 'api key as credentials' do
        let(:credentials) { TEST_API_CREDENTIALS_WITH_KEY }
        it { is_expected.to match(/^[a-zA-Z0-9_-]{,20}$/) }
      end
    end

  end

end
