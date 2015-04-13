require 'spec_helper'

describe Locomotive::Coal::Resources::MyAccount do

  before { VCR.insert_cassette 'my_account', record: :new_episodes, match_requests_on: [:method, :query, :body] }
  after  { VCR.eject_cassette }

  let(:uri)         { TEST_API_V3_URI }
  let(:credentials) { { email: TEST_API_EMAIL, token: api_token } }
  let(:resource)    { described_class.new(uri, credentials) }

  describe '#get' do
    subject { resource.get }
    it { expect(subject.name).not_to eq nil }
  end

  describe '#create' do
    let(:credentials) { nil }
    let(:attributes)  { { name: 'Jack Doe', email: 'jack@doe.net', password: 'easyone', password_confirmation: 'easyone' } }
    subject { resource.create(attributes) }
    it { expect(subject._id).not_to eq nil }

    describe 'missing attributes' do
      let(:attributes) { { name: 'Wrong account' } }
      it { expect { subject }.to raise_error(Locomotive::Coal::InvalidResourceError, 'Resource invalid: email is missing, password is missing') }
    end
  end

  describe '#update' do
    subject { resource.update(name: 'John Doe') }
    it { expect(subject._id).not_to eq nil }
  end

end
