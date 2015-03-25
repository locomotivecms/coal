require 'spec_helper'

describe Locomotive::Coal::Resources::Sites do

  before { VCR.insert_cassette 'sites', record: :new_episodes }
  after  { VCR.eject_cassette }

  let(:uri)     { TEST_API_URI }
  let(:token)   { api_token }
  let(:sites)   { described_class.new(uri, token) }

  describe '#all' do
    subject { sites.all }
    it { expect(subject.size).to be > 0 }

    describe 'first site' do
      subject { sites.all.first }
      it { expect(subject.name).not_to eq nil }
    end
  end

end
