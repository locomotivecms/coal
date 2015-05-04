require 'spec_helper'

describe Locomotive::Coal::Resources::ThemeAssets, order: :defined do

  before { VCR.insert_cassette 'theme_assets', record: :new_episodes }
  after  { VCR.eject_cassette }

  let(:uri)           { TEST_SITE_API_V3_URI }
  let(:credentials)   { { email: TEST_API_EMAIL, token: api_token } }
  let(:theme_assets)  { described_class.new(uri, credentials) }

  describe '#all' do
    subject { theme_assets.all }
    it { expect(subject).not_to eq nil }
  end

  describe '#create' do
    subject { create_theme_asset }
    it { expect(subject._id).not_to eq nil }
  end

  describe '#update' do
    let(:theme_asset) { single_theme_asset || create_theme_asset }
    subject { theme_assets.update(theme_asset._id, folder: 'header') }
    it { expect(subject.url).to match /theme\/images\/header\/rails.png$/ }
  end

  describe '#destroy' do
    let(:theme_asset) { single_theme_asset || create_theme_asset }
    subject { theme_assets.destroy(theme_asset._id) }
    it { expect(subject._id).not_to eq nil }
  end

  def create_theme_asset
    file = Locomotive::Coal::UploadIO.new(File.join(File.dirname(__FILE__), '..', '..', 'fixtures', 'assets', 'rails.png'))
    theme_assets.create(source: file, folder: 'footer' )
  end

  def single_theme_asset
    theme_assets.all.detect { |a| a.url =~ /theme\/images\/footer\/rails.png$/ }
  end

end
