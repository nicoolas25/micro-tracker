RSpec.describe Utracker::Drawer::Node do
  let(:instance) { described_class.new('name') }

  describe "#==" do
    subject { instance == other_instance }

    context "when the other instance has the same service name" do
      let(:other_instance) { described_class.new(instance.service) }
      it { is_expected.to be true }
    end

    context "when the other instance has a different service name" do
      let(:other_instance) { described_class.new('name2') }
      it { is_expected.to be false }
    end
  end
end
