require 'spec_helper'

describe Locomotive::Coal::Resources::Pages, order: :defined do

  before { VCR.insert_cassette 'pages', record: :new_episodes }
  after  { VCR.eject_cassette }

  let(:uri)         { TEST_SITE_API_V3_URI }
  let(:credentials) { { email: TEST_API_EMAIL, token: api_token } }
  let(:pages)       { described_class.new(uri, credentials) }

  describe '#all' do
    subject { pages.all }
    it { expect(subject).not_to eq nil }
  end

  describe '#create' do
    subject { create_page }
    it { expect(subject._id).not_to eq nil }
  end

  describe '#update' do
    let(:page) { pages.all.detect { |s| s.fullpath == 'about-us' } || create_page }
    subject { pages.update(page._id, template: 'Locomotive rocks. period') }
    it { expect(subject.template).to eq 'Locomotive rocks. period' }
  end

  describe '#destroy' do
    let(:page) { pages.all.detect { |s| s.fullpath == 'about-us' } || create_page }
    subject { pages.destroy(page._id) }
    it { expect(subject._id).not_to eq nil }
  end

  def create_page
    pages.create(title: 'About us', slug: 'about-us', parent: 'index', template: 'Locomotive rocks!')
  end

end
