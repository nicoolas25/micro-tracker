RSpec.describe Utracker do
  let(:config) { Utracker.config }

  describe ".config" do
    subject { config }
    it { is_expected.to be_a Hash }
    it { is_expected.to be_frozen }

    describe "the default 'logger_class' value" do
      subject { config[:logger_class] }
      it { is_expected.to be Utracker::StdoutLogger }
    end
  end

  describe ".configure" do
    before { Utracker.configure(&block) }

    describe "the resulting config[:key] value" do
      subject { config[:key] }

      context "when the value has been defined in the configure's block" do
        let(:block) { proc do |hash| hash[:key] = :value end }
        it { is_expected.to eq :value }
      end

      context "when the value has not been defined in the configure's block" do
        let(:block) { proc do |hash| hash[:other_key] = :value end }
        it { expect{ subject }.to raise_error }
      end
    end
  end

  describe ".logger" do
    subject { Utracker.logger }
    it { is_expected.to be_a Utracker::Logger }
  end
end
