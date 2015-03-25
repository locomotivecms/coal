require 'spec_helper'

describe Locomotive::Coal::Client do

  let(:uri)         { nil }
  let(:credentials) { nil }
  let(:client)      { described_class.new(uri, credentials) }

  describe '#initialize' do

    subject { client }

    context 'no uri' do
      let(:credentials) { { email: 'fake' } }
      it { expect { subject }.to raise_error Locomotive::Coal::MissingURIOrCredentialsError }
    end

    context 'no credentials' do
      let(:uri) { 'http://sample.lvh.me:4000/locomotive/api' }
      it { expect { subject }.to raise_error Locomotive::Coal::MissingURIOrCredentialsError }
    end

  end

end
