RSpec.describe Utracker::Message do
  describe '#log' do
    subject(:log_event) { message.log(event) }

    before do
      allow(Utracker).to receive(:logger).and_return(logger)
    end

    let(:message) { described_class.pack('payload') }
    let(:event) { 'event description' }
    let(:logger) { double('Logger', log: true) }

    it 'logs the event using the Utracker logger' do
      expect(Utracker.logger).to receive(:log).with(message, event, {})
      log_event
    end

    context 'whith extra options as last argument' do
      subject(:log_event) { message.log(event, options) }

      let(:options) { double('Hash') }

      it 'passes the options to the Utracker logger' do
        expect(Utracker.logger).to receive(:log).with(message, event, options)
        log_event
      end
    end
  end
end
