require 'spec_helper'

describe Locomotive::Coal::Resources::Memberships, order: :defined do

  before { VCR.insert_cassette 'memberships', record: :new_episodes }
  after  { VCR.eject_cassette }

  let(:uri)         { TEST_SITE_API_V3_URI }
  let(:credentials) { { email: TEST_API_EMAIL, token: api_token } }
  let(:memberships) { described_class.new(uri, credentials) }

  describe '#all' do
    subject { memberships.all }
    it { expect(subject).not_to eq nil }
  end

end
