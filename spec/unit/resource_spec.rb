require 'spec_helper'

describe Locomotive::Coal::Resource do

  let(:attributes)  { { 'title' => 'Hello world' } }
  let(:resource)    { described_class.new(attributes) }

  describe 'unknown attribute' do
    subject { resource.name }
    it { expect { subject }.to raise_error(NoMethodError, /undefined method `name'/) }
  end

  describe 'existing attribute' do
    subject { resource.title }
    it { is_expected.to eq 'Hello world' }
  end

  describe '#respond_to?' do
    let(:name) { :title }
    subject { resource.respond_to?(name) }
    it { is_expected.to eq true }

    context 'unknown attribute' do
      let(:name) { :body }
      it { is_expected.to eq false }
    end
  end

end
