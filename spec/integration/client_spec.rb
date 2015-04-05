require 'spec_helper'

describe Locomotive::Coal::Client do

  # before { VCR.insert_cassette 'client', record: :new_episodes }
  # after  { VCR.eject_cassette }

  let(:uri)         { TEST_API_URI }
  let(:credentials) { TEST_API_CREDENTIALS }
  let(:client)      { described_class.new(uri, credentials) }

  describe '#my_token' do
    subject { client.token }
    it { is_expected.not_to eq nil }
  end

  describe '#my_account' do
    subject { client.my_account.get.name }
    it { is_expected.not_to eq nil }
  end

  describe '#sites' do
    subject { client.sites.all.first }
    it { is_expected.not_to eq nil }
  end

  describe '#scope_by' do
    let(:uri) { 'http://www.example.com:3000/locomotive/api/v3' }
    let(:site) { client.sites.all.first }
    subject { client.scope_by(site) }
    it { is_expected.to eq client }
  end

end
