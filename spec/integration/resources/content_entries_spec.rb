require 'spec_helper'

describe Locomotive::Coal::Resources::ContentEntries do

  before(:all) do
    VCR.insert_cassette 'content_entries', record: :new_episodes, match_requests_on: [:method, :query, :body]
    @content_type = build_content_types.create(name: 'Article', slug: 'articles', fields: [{ label: 'Title', name: 'title', type: 'string', localized: true }])
  end

  after(:all) do
    build_content_types.destroy(@content_type._id)
    VCR.eject_cassette
  end

  let(:uri)           { TEST_SITE_API_V3_URI }
  let(:credentials)   { { email: TEST_API_EMAIL, token: api_token } }
  let(:content_type)  { @content_type }
  let(:entries)       { described_class.new(uri, credentials, content_type) }

  describe '#all' do

    let(:query)   { {} }
    let(:options) { {} }

    subject { entries.all(query, options) }

    before { entries.create(title: 'Hello world'); entries.create(title: 'Lorem ipsum') }
    after { ['hello-world', 'lorem-ipsum'].each { |slug| entries.destroy(slug) } }

    it 'returns a paginated list of entries' do
      expect(subject.size).to be >= 2
      expect(subject._total_pages).to eq 1
      expect(subject._total_entries).to be >= 2
    end

    describe 'pagination' do

      let(:options) { { page: 2, per_page: 1 } }

      it 'returns the second page of entries' do
        expect(subject.size).to eq 1
        expect(subject._total_pages).to be >= 2
        expect(subject._total_entries).to be >= 2
      end

    end

    describe 'filter' do

      let(:query) { { _visible: true, title: 'Hello world' } }

      it { expect(subject.size).to eq 1 }

    end

  end

  describe '#update' do

    let(:entry) { entries.create(title: 'Random title') }
    subject { entries.update(entry._slug, { title: 'Random title!' }) }

    it { expect(subject.title).to eq 'Random title!' }

    describe 'with a localized content entry' do

      subject { entries.update(entry._id, { title: 'Titre au hasard' }, :fr) }

      it { expect(subject.title).to eq 'Titre au hasard' }

    end

  end

  def build_content_types
    Locomotive::Coal::Resources::ContentTypes.new(TEST_SITE_API_V3_URI, { email: TEST_API_EMAIL, token: api_token })
  end

end
