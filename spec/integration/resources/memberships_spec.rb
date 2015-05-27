require 'spec_helper'

describe Locomotive::Coal::Resources::Memberships, order: :defined do

  before { VCR.insert_cassette 'memberships', record: :new_episodes }
  after  { VCR.eject_cassette }

  let(:uri)               { TEST_SITE_API_V3_URI }
  let(:credentials)       { { email: TEST_API_EMAIL, token: api_token } }
  let(:memberships)       { described_class.new(uri, credentials) }
  let(:new_account_email) { 'new_admin@locomotivecms.com' }

  describe '#all' do
    subject { memberships.all }
    it { expect(subject).not_to eq nil }
  end

  describe '#create' do
    subject { create_membership }
    it { expect(subject._id).not_to eq nil }
  end

  describe '#update' do
    let(:membership) { memberships.all.detect { |s| s.email == new_account_email } || create_membership }
    subject { memberships.update(membership._id, role: 'author') }
    it { expect(subject.role).to eq 'author' }
  end

  describe '#destroy' do
    let(:membership) { memberships.all.detect { |s| s.email == new_account_email } || create_membership }
    subject { memberships.destroy(membership._id) }
    it { expect(subject._id).to_not eq nil }
  end

  def create_membership
    memberships.create(role: 'Admin', account_email: new_account_email)
  end

end
