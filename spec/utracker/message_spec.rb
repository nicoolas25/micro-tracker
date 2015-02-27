RSpec.describe Utracker::Message do
  let(:packed_message) { described_class.pack(payload) }
  let(:unpacked_message) { described_class.unpack(serialization) }
  let(:serialization) { packed_message.to_json }
  let(:payload) { {'this' => 'is my mayload'} }

  describe 'instanciation by packing a payload' do
    subject { packed_message }
    it { is_expected.to be_a described_class }
  end

  describe 'instanciation by unpacking a Message serialization' do
    subject { unpacked_message }
    it { is_expected.to be_a described_class }
  end

  describe '#uuid' do
    subject { instance.uuid }

    context 'when we packed a payload' do
      let(:instance) { packed_message }
      it { is_expected.to match /^[a-f0-9]{8}-([a-f0-9]{4}-){3}[a-f0-9]{12}$/ }
      it { is_expected.to eq instance.uuid }
    end

    context 'when we unpacked a serialized payload' do
      let(:instance) { unpacked_message }
      it { is_expected.to eq packed_message.uuid }
    end
  end

  describe '#content' do
    subject { instance.content }

    context 'when we packed a payload' do
      let(:instance) { packed_message }
      it { is_expected.to eq payload }
    end

    context 'when we unpacked a serialized payload' do
      let(:instance) { unpacked_message }
      it { is_expected.to eq payload }
    end
  end
end
