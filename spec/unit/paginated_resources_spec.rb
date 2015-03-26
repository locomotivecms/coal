require 'spec_helper'

describe Locomotive::Coal::PaginatedResources do

  let(:list)          { ['a', 42, :foo] }
  let(:total_pages)   { 1 }
  let(:total_entries) { 3 }
  let(:paginate)      { described_class.new(list, total_pages, total_entries) }

  describe '#find' do
    subject { paginate.find { |el| el == 42 } }
    it { is_expected.to eq 42 }
  end

  describe '#each' do
    it { expect(paginate.respond_to?(:each)).to eq true }
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
