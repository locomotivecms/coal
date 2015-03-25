require 'spec_helper'

describe Locomotive::Coal::Resources::MyAccount do

  let(:uri)         { nil }
  let(:token)       { nil }
  let(:my_account)  { described_class.new(uri, token) }

  describe '#get' do

    let(:uri)   { TEST_API_URI }
    let(:token) { api_token }

    subject { my_account.get }

    it { expect(subject.name).not_to eq nil }

  end

end
