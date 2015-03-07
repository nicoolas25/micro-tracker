RSpec.describe Utracker do
  let(:config) { Utracker.config }
  before { Utracker.configure {} }

  describe ".config" do
    subject { config }
    it { is_expected.to be_a Hash }
    it { is_expected.to be_frozen }

    describe "the default :logger_class value" do
      subject { config[:logger_class] }
      it { is_expected.to be Utracker::StdoutLogger }
    end

    describe "the default :formatter value" do
      subject { config[:formatter] }
      it { is_expected.to be_an_instance_of Proc }

      describe "the default formatter" do
        subject { config[:formatter][its_argument] }
        let(:its_argument) { double }
        it { is_expected.to be its_argument }
      end
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

    context 'when the :logger_class config key had been configured' do
      before { Utracker.configure { |config| config[:logger_class] = logger_class } }
      let(:logger_class) { Time }
      it { is_expected.to be_a logger_class }
    end
  end
end
