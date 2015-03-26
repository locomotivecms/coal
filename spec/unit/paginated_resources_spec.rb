require 'spec_helper'

describe Locomotive::Coal::PaginatedResources do

  let(:list)          { ['a', 42, :foo] }
  let(:page)          { 1 }
  let(:total_pages)   { 1 }
  let(:total_entries) { 3 }
  let(:paginate)      { described_class.new(list, page, total_pages, total_entries) }

  describe '#find' do
    subject { paginate.find { |el| el == 42 } }
    it { is_expected.to eq 42 }
  end

  describe '#each' do
    it { expect(paginate.respond_to?(:each)).to eq true }
  end

  describe '#_next_page' do
    subject { paginate._next_page }
    it { is_expected.to eq nil }

    context '3 pages of entries' do
      let(:total_pages) { 3 }
      it { is_expected.to eq 2 }

      context 'current page is the last one' do
        let(:page) { 3 }
        it { is_expected.to eq nil }
      end
    end
  end

  describe '#_page' do
    subject { paginate._page }
    it { is_expected.to eq 1 }
  end

  describe '#_total_pages' do
    subject { paginate._total_pages }
    it { is_expected.to eq 1 }
  end

  describe '#_total_entries' do
    subject { paginate._total_entries }
    it { is_expected.to eq 3 }
  end

end
