require 'spec_helper'

describe Locomotive::Coal::Resource do

  let(:attributes)  { { 'title' => 'Hello world' } }
  let(:resource)    { described_class.new(attributes) }

  describe 'unknown attribute' do
    subject { resource.name }
    it { expect { subject }.to raise_error }
  end

  describe 'existing attribute' do
    subject { resource.title }
    it { is_expected.to eq 'Hello world' }
  end

end
