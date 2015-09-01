require 'spec_helper'

describe Locomotive::Coal::Client do

  let(:uri)         { 'http://sample.lvh.me:4000/locomotive/api' }
  let(:credentials) { { email: 'fake' } }
  subject           { described_class.new(uri, credentials) }

  describe '#initialize' do

    context 'no uri' do
      let(:uri) { nil }
      it { expect { subject }.to raise_error Locomotive::Coal::MissingURIOrCredentialsError }
    end

    context 'no credentials' do
      let(:credentials) { nil }
      it { expect { subject }.to raise_error Locomotive::Coal::MissingURIOrCredentialsError }
    end

  end

  describe 'resources' do
    describe '#current_site' do
      subject { super().current_site }
      it { is_expected.to be_a Locomotive::Coal::Resources::CurrentSite }
    end

    describe '#pages' do
      subject { super().pages }
      it { is_expected.to be_a Locomotive::Coal::Resources::Pages }
    end

    describe '#content_types' do
      subject { super().content_types }
      it { is_expected.to be_a Locomotive::Coal::Resources::ContentTypes }
    end

    describe '#content_entries' do
      subject { super().content_entries(content_type) }
      let(:content_type) { double(:content_type, slug: 'abc') }
      it { is_expected.to be_a Locomotive::Coal::Resources::ContentEntries }
    end

    describe '#content_assets' do
      subject { super().content_assets }
      it { is_expected.to be_a Locomotive::Coal::Resources::ContentAssets }

    end
  end

end
