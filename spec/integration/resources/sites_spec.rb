require 'spec_helper'

describe Locomotive::Coal::Resources::Sites do

  # before { VCR.insert_cassette 'sites', record: :new_episodes }
  # after  { VCR.eject_cassette }

  let(:uri)         { TEST_API_URI }
  let(:credentials) { { email: TEST_API_EMAIL, token: api_token } }
  let(:sites)       { described_class.new(uri, credentials) }

  describe '#all' do

    subject { sites.all }
    it { expect(subject.size).to be > 0 }

    describe 'first site' do
      subject { sites.all.first }
      it { expect(subject.name).not_to eq nil }
    end
  end

  describe '#create' do
    subject { create_site }
    it { expect(subject._id).not_to eq nil }
  end

  describe '#by_handle' do
    subject { sites.by_handle('sample') }
    it { expect(subject._id).not_to eq nil }
  end

  describe '#destroy' do
    let(:new_site) { sites.by_handle('acme') || create_site }
    subject { sites.destroy(new_site._id) }
    it { expect(subject._id).not_to eq nil }
  end

  def create_site
    sites.create(name: 'Acme', handle: 'acme', locales: ['en'])
  end

end
