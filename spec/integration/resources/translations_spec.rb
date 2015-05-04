require 'spec_helper'

describe Locomotive::Coal::Resources::Translations, order: :defined do

  before { VCR.insert_cassette 'translations', record: :new_episodes }
  after  { VCR.eject_cassette }

  let(:uri)           { TEST_SITE_API_V3_URI }
  let(:credentials)   { { email: TEST_API_EMAIL, token: api_token } }
  let(:translations)  { described_class.new(uri, credentials) }

  describe '#all' do
    subject { translations.all }
    it { expect(subject).not_to eq nil }
  end

  describe '#create' do
    subject { create_translation }
    it { expect(subject._id).not_to eq nil }
  end

  describe '#update' do
    let(:translation) { translations.all.detect { |s| s.key == 'hello' } || create_translation }
    subject { translations.update(translation._id, values: { 'en' => 'Hello world!', 'fr' => 'Bonjour le monde!' }) }
    it { expect(subject.values).to eq('en' => 'Hello world!', 'fr' => 'Bonjour le monde!') }
  end

  describe '#destroy' do
    let(:translation) { translations.all.detect { |s| s.key == 'hello' } || create_translation }
    subject { translations.destroy(translation._id) }
    it { expect(subject._id).not_to eq nil }
  end

  def create_translation
    translations.create(key: 'hello', values: { 'en' => 'Hello world', 'fr' => 'Bonjour le monde' })
  end

end
