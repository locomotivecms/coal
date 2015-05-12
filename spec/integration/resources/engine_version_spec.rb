require 'spec_helper'

describe Locomotive::Coal::Resources::EngineVersion do

  before { VCR.insert_cassette 'version' }
  after  { VCR.eject_cassette }

  let(:uri)           { TEST_SITE_API_V3_URI }
  let(:credentials)   { { email: TEST_API_EMAIL, token: api_token } }
  let(:engine_version)  { described_class.new(uri, credentials) }

  describe '#version' do
    subject { engine_version.version }
    it { is_expected.to match(/\A\d\..+/) }
  end

end
