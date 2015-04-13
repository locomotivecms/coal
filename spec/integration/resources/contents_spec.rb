require 'spec_helper'

describe Locomotive::Coal::Resources::Contents do

  before { VCR.insert_cassette 'contents', record: :new_episodes }
  after  { VCR.eject_cassette }

  let(:uri)         { TEST_API_V3_URI }
  let(:credentials) { { email: TEST_API_EMAIL, token: api_token } }
  let(:contents)    { described_class.new(uri, credentials) }

  describe '#by_slug' do
    subject { contents.by_slug(:bands) }
    it { expect(subject).not_to eq nil }
  end

  describe '#method_missing' do
    subject { contents.bands }
    it { expect(subject).not_to eq nil }
  end

end
