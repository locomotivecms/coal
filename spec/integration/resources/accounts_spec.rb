require 'spec_helper'

describe Locomotive::Coal::Resources::Accounts, order: :defined do

  before { VCR.insert_cassette 'accounts', record: :new_episodes }
  after  { VCR.eject_cassette }

  let(:uri)         { TEST_API_V3_URI }
  let(:credentials) { { email: TEST_API_EMAIL, token: api_token } }
  let(:accounts)    { described_class.new(uri, credentials) }

  describe '#all' do

    subject { accounts.all }
    it { expect(subject.size).to be > 0 }

    describe 'first account' do
      subject { accounts.all }
      it { expect(subject.to_a.map { |a| a.name }).to include('New Admin', 'John Doe') }
    end
  end

  describe '#create' do
    subject { create_account }
    it { expect(subject._id).not_to eq nil }
  end

  describe '#destroy' do
    let(:new_account) { accounts.all.find { |a| a.email == 'jane@doe.net' } || create_account }
    subject { accounts.destroy(new_account._id) }
    it { expect(subject._id).not_to eq nil }
  end

  def create_account
    accounts.create(name: 'Jane', email: 'jane@doe.net', password: 'easyone', password_confirmation: 'easyone')
  end

end
