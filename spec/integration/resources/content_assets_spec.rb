require 'spec_helper'

describe Locomotive::Coal::Resources::ContentAssets, order: :defined do

  before { VCR.insert_cassette 'content_assets', record: :new_episodes }
  after  { VCR.eject_cassette }

  let(:uri)           { TEST_SITE_API_V3_URI }
  let(:credentials)   { { email: TEST_API_EMAIL, token: api_token } }
  let(:content_assets)  { described_class.new(uri, credentials) }

  describe '#all' do
    subject { content_assets.all }
    it { expect(subject).not_to eq nil }
  end

  describe '#create' do
    subject { create_content_asset }
    it { expect(subject._id).not_to eq nil }
  end

  describe '#update' do
    let(:content_asset) { single_content_asset || create_content_asset }
    subject { content_assets.update(content_asset._id, source: asset_io('locomotive.png')) }
    it { expect(subject.url).to match /locomotive.png$/ }
  end

  describe '#destroy' do
    let(:content_asset) { single_content_asset || create_content_asset }
    subject { content_assets.destroy(content_asset._id) }
    it { expect(subject._id).not_to eq nil }
  end

  def create_content_asset
    content_assets.create(source: asset_io('rails.png'))
  end

  def single_content_asset
    content_assets.all.detect { |a| a.url =~ /rails.png$/ }
  end

end
