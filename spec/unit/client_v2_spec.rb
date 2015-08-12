describe Locomotive::Coal::ClientV2 do
  let(:site) { double(:site, domains: [domain]) }

  let(:client) { described_class.new('abc.com', { foo: :bar }) }

  describe '#scope_by' do
    subject { client.scope_by(site) }

    context 'domains include current site' do
      let(:domain) { 'abc.com' }
      it { is_expected.to eq client }
    end

    context 'domains do not include current site' do
      let(:domain) { 'xyz.com' }
      it { is_expected.to_not eq client }

    end
  end


end
