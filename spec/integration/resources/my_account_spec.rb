require 'spec_helper'

describe Locomotive::Coal::Resources::MyAccount do

  before { VCR.insert_cassette 'my_account', record: :new_episodes, match_requests_on: [:method, :body] }
  after  { VCR.eject_cassette }

  let(:uri)         { TEST_API_URI }
  let(:token)       { api_token }
  let(:resource)    { described_class.new(uri, token) }

  describe '#get' do
    subject { resource.get }
    it { expect(subject.name).not_to eq nil }
  end

  describe '#create' do
    let(:attributes) { { name: 'Jane Doe', email: 'jane@doe.net', password: 'easyone', password_confirmation: 'easyone' } }
    subject { resource.create(attributes) }
    it { expect(subject._id).not_to eq nil }

    describe 'missing attributes' do
      let(:attributes) { {} }
      it { expect { subject }.to raise_error(Locomotive::Coal::InvalidResourceError) }
    end
  end

  describe '#update' do
    subject { resource.update(name: 'John Doe') }
    it { expect(subject._id).not_to eq nil }
  end

end
