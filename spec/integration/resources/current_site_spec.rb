require 'spec_helper'

describe Locomotive::Coal::Resources::CurrentSite do

  before { VCR.insert_cassette 'current_site', record: :new_episodes, match_requests_on: [:method, :query, :body] }
  after  { VCR.eject_cassette }

  let(:uri)         { TEST_SITE_API_V3_URI }
  let(:credentials) { { email: TEST_API_EMAIL, token: api_token } }
  let(:resource)    { described_class.new(uri, credentials) }

  describe '#get' do
    subject { resource.get }
    it { expect(subject.name).not_to eq nil }
  end

  describe '#update' do
    subject { resource.update(name: 'John Doe') }
    it { expect(subject._id).not_to eq nil }
  end

end
