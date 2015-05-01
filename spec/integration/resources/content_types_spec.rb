require 'spec_helper'

describe Locomotive::Coal::Resources::ContentTypes do

  before(:all) { VCR.insert_cassette 'content_types', record: :new_episodes, match_requests_on: [:method, :query, :body] }
  after(:all)  { VCR.eject_cassette }

  let(:uri)           { TEST_SITE_API_V3_URI }
  let(:credentials)   { { email: TEST_API_EMAIL, token: api_token } }
  let(:content_types) { described_class.new(uri, credentials) }

  describe '#all' do
    subject { content_types.all }
    it { expect(subject).not_to eq nil }
  end

  describe '#create' do
    subject { create_content_type }
    it { expect(subject._id).not_to eq nil }
  end

  describe '#update' do
    let(:content_type) { content_types.all.detect { |s| s.slug == 'articles' } || create_content_type }
    subject { content_types.update(content_type._id, name: 'Our articles') }
    it { expect(subject.name).to eq 'Our articles' }
  end

  describe '#destroy' do
    let(:content_type) { content_types.all.detect { |s| s.slug == 'articles' } || create_content_type }
    subject { content_types.destroy(content_type._id) }
    it { expect(subject._id).not_to eq nil }
  end

  describe '#by_slug' do
    before { content_types.all.detect { |s| s.slug == 'articles' } || create_content_type }
    subject { content_types.by_slug(:articles) }
    it { expect(subject).not_to eq nil }
  end

  def create_content_type
    content_types.create(name: 'Article', slug: 'articles', fields: [{ label: 'Title', name: 'title', type: 'string' }])
  end

end
