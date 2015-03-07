RSpec.describe Utracker::Logger::Event do
  let(:event) { described_class.new(nil, nil, nil, message, options) }
  let(:message) { double('Message', content: 'Hello') }
  let(:options) { {} }

  describe "#payload" do
    before do
      Utracker.configure do |config|
        config[:formatter] = ->(_){ formatter_result }
      end
    end

    subject { event.payload }
    let(:formatter_result) { double }

    it { is_expected.to be formatter_result }
  end
end
