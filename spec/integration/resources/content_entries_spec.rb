require 'spec_helper'

describe Locomotive::Coal::Resources::ContentEntries do

  before(:all) do
    VCR.insert_cassette 'content_entries', record: :new_episodes
    build_content_types.create(name: 'Article', slug: 'articles', fields: [{ label: 'Title', name: 'title', type: 'string' }])
  end

  after(:all) do
    build_content_types.destroy('articles')
    VCR.eject_cassette
  end

  let(:uri)           { TEST_SITE_API_V3_URI }
  let(:credentials)   { { email: TEST_API_EMAIL, token: api_token } }
  let(:content_types) { build_content_types }
  let(:content_type)  { content_types.by_slug(:articles) }
  let(:entries)       { described_class.new(uri, credentials, content_type) }

  # before(:all) {  }
  # after(:all) { build_content_types.destroy(content_type.slug) }

  describe '#all' do

    let(:query)   { {} }
    let(:options) { {} }

    subject { entries.all(query, options) }

    before { @entries = [entries.create(title: 'Hello world'), entries.create(title: 'Lorem ipsum')] }
    after { @entries.each { |entry| entries.destroy(entry._slug) } }

    it 'returns a paginated list of entries' do
      expect(subject.size).to eq 2
      expect(subject._total_pages).to eq 1
      expect(subject._total_entries).to eq 2
    end

    describe 'pagination' do

      let(:options) { { page: 2, per_page: 1 } }

      it 'returns the second page of entries' do
        expect(subject.size).to eq 1
        expect(subject._total_pages).to eq 2
        expect(subject._total_entries).to eq 2
      end

    end

    describe 'filter' do

      let(:query) { { _visible: true, title: 'Hello world' } }

      it { expect(subject.size).to eq 1 }

    end
  end

  describe '#update' do

    let(:entry) { entries.create(title: 'Hello world') }
    subject { entries.update(entry._slug, { name: 'Hello world!' }) }

    it { expect(subject.title).to eq 'Hello world!' }

  end

  def build_content_types
    Locomotive::Coal::Resources::ContentTypes.new(TEST_SITE_API_V3_URI, { email: TEST_API_EMAIL, token: api_token })
  end

end
