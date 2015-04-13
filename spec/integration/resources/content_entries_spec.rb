require 'spec_helper'

describe Locomotive::Coal::Resources::ContentEntries do

  before { VCR.insert_cassette 'content_entries', record: :new_episodes }
  after  { VCR.eject_cassette }

  let(:uri)           { TEST_API_V3_URI }
  let(:token)         { api_token }
  let(:content_type)  { Locomotive::Coal::Resources::Contents.new(uri, token).by_slug(:bands) }
  let(:entries)       { described_class.new(uri, token, content_type) }

  describe '#all' do

    let(:query)   { {} }
    let(:options) { {} }

    subject { entries.all(query, options) }

    it { expect(subject.size).not_to eq 0 }
    it { expect(subject._total_pages).not_to eq 0 }
    it { expect(subject._total_entries).not_to eq 0 }

    describe 'pagination' do

      let(:options) { { page: 2, per_page: 2 } }

      it { expect(subject.size).not_to eq 0 }
      it { expect(subject._total_pages).to be > 1 }
      it { expect(subject._total_entries).to be > 1 }

    end

    describe 'filter' do

      let(:query) { { _visible: true, name: 'Pearl Jam' } }

      it { expect(subject.size).to eq 1 }

    end
  end

  describe '#update' do

    let(:entry) { entries.all[1] }
    subject { entries.update(entry._id, { name: 'Pearl Jam' }) }

    it { expect(subject._id).to eq entry._id }

  end

end
