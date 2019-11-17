require 'spec_helper'

describe Locomotive::Coal::Resources::Sections, order: :defined do

  before { VCR.insert_cassette 'sections', record: :new_episodes }
  after  { VCR.eject_cassette }

  let(:uri)         { TEST_SITE_API_V3_URI }
  let(:credentials) { { email: TEST_API_EMAIL, token: api_token } }
  let(:sections)    { described_class.new(uri, credentials) }

  describe '#all' do
    subject { sections.all }
    it { expect(subject).not_to eq nil }
  end

  describe '#create' do
    subject { create_section }
    it { expect(subject._id).not_to eq nil }
  end

  describe '#update' do
    let(:section) { sections.all.detect { |s| s.slug == 'sidebar' } || create_section }
    subject { sections.update(section._id, template: 'Locomotive rocks. period') }
    it { expect(subject.template).to eq 'Locomotive rocks. period' }
  end

  describe '#destroy' do
    let(:section) { sections.all.detect { |s| s.slug == 'sidebar' } || create_section }
    subject { sections.destroy(section._id) }
    it { expect(subject._id).not_to eq nil }
  end

  def create_section
    sections.create(name: 'Sidebar', slug: 'sidebar', template: 'Locomotive rocks!', definition: {
      name: 'sidebar',
      settings: [
        {
          id:   'title',
          type: 'text'
        }
      ]
    })
  end

end
