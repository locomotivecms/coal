require 'spec_helper'

describe Locomotive::Coal::Client do

  before { VCR.insert_cassette 'client', record: :new_episodes }
  after  { VCR.eject_cassette }

  let(:uri)         { 'http://sample.lvh.me:4000/locomotive/api' }
  let(:credentials) { { email: 'john@doe.net', password: 'easyone' } }
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

end
