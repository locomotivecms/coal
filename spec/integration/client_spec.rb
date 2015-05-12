require 'spec_helper'

describe Locomotive::Coal::Client do

  before { VCR.insert_cassette 'client', record: :new_episodes }
  after  { VCR.eject_cassette }

  let(:uri)         { TEST_API_URI.dup }
  let(:credentials) { TEST_API_CREDENTIALS.dup }
  let(:options)     { {} }
  let(:client)      { described_class.new(uri, credentials, options) }

  describe '#my_token' do
    subject { client.token }
    it { is_expected.not_to eq nil }
  end

  describe '#my_account' do
    subject { client.my_account.get.name }
    it { is_expected.not_to eq nil }
  end

  describe '#engine_version' do
    subject { client.engine_version }
    it { is_expected.to match(/\A\d\..+/) }
  end

  describe '#version' do
    subject { client.version }
    it { is_expected.to match(/\A\d\..+/) }
  end

  describe '#sites' do
    subject { client.sites.all.first }
    it { is_expected.not_to eq nil }
  end

  context 'scoped by a site' do

    let(:options) { { handle: 'sample' } }

    describe '#snippets' do
      subject { client.snippets.all }
      it { is_expected.to eq [] }
    end

    describe '#translations' do
      subject { client.translations.all }
      it { is_expected.to eq [] }
    end

    describe '#theme_assets' do
      subject { client.theme_assets.all }
      it { is_expected.to eq [] }
    end

  end

  describe '#scope_by' do
    let(:uri) { 'http://www.example.com:3000/locomotive/api/v3' }
    let(:site) { client.sites.all.first }
    subject { client.scope_by(site) }
    it { is_expected.to eq client }
    it { expect(subject.options[:handle]).to eq 'www' }
  end

end
