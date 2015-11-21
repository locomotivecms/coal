require 'spec_helper'

describe Locomotive::Coal::Error do

  let(:status)      { nil }
  let(:body)        { {} }
  let(:response)    { instance_double('Response', status: status, body: body) }
  let(:error)       { described_class.from_response(response) }

  describe '#message' do

    subject { error.message }

    context 'error caused by a wrong answer from the server' do

      context 'invalid resource (422)' do
        let(:status) { 422 }
        let(:body) { { 'error' => 'Resource invalid', 'attributes' => { 'name' => ["can't be blank"] } } }

        it { is_expected.to eq "Resource invalid: name can't be blank" }

      end

      context 'Request Entity Too Large (413)' do

        let(:status) { 413 }

        it { is_expected.to eq "File too big for the server" }

      end

    end

  end

end
