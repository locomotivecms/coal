require 'spec_helper'

describe Locomotive::Coal::Resources::Snippets do

  before { VCR.insert_cassette 'snippets', record: :new_episodes }
  after  { VCR.eject_cassette }

  let(:uri)         { TEST_SITE_API_V3_URI }
  let(:credentials) { { email: TEST_API_EMAIL, token: api_token } }
  let(:snippets)    { described_class.new(uri, credentials) }

  describe '#all' do
    subject { snippets.all }
    it { expect(subject).not_to eq nil }
  end

  describe '#create' do
    subject { create_snippet }
    it { expect(subject._id).not_to eq nil }
  end

  describe '#update' do
    let(:snippet) { snippets.all.detect { |s| s.slug == 'footer' } || create_snippet }
    subject { snippets.update(snippet._id, template: 'Locomotive rocks. period') }
    it { expect(subject.template).to eq 'Locomotive rocks. period' }
  end

  describe '#destroy' do
    let(:snippet) { snippets.all.detect { |s| s.slug == 'footer' } || create_snippet }
    subject { snippets.destroy(snippet._id) }
    it { expect(subject._id).not_to eq nil }
  end

  def create_snippet
    snippets.create(name: 'Footer', slug: 'footer', template: 'Locomotive rocks!')
  end

end
