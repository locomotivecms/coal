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
        let(:uri) { URI('http://www.example.com:4000') }
        let(:credentials) { { email: 'john@doe.net', password: 'easyone' } }
        it { expect { subject }.to raise_error Locomotive::Coal::UnknownResourceError }
      end

    context 'valid uri' do
      let(:uri) { TEST_API_URI }

      context 'email + password as credentials' do
        let(:credentials) { { email: 'john@doe.net', password: 'easyone' } }
        it { is_expected.to match(/^[a-zA-Z0-9]{,20}$/) }
      end

      context 'api key as credentials' do
        let(:credentials) { { email: 'john@doe.net', api_key: 'a9ac1e08c2c22c1b6f3da6db77a70cac4a615bd7' } }
        it { is_expected.to match(/^[a-zA-Z0-9]{,20}$/) }
      end
    end

  end

end
