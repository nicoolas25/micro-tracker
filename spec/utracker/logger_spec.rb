RSpec.describe Utracker::Logger do
  before do
    Utracker.configure { |config| config[:service_name] = service_name }
  end

  let(:instance) { described_class.new }
  let(:service_name) { 'Test suite service' }

  describe '#log' do
    subject(:log_event) { instance.log(message, description) }

    let(:message) { double('Message') }
    let(:description) { 'event description' }

    it 'writes an event built with the current time, service name, description and message' do
      Timecop.freeze do
        expect(instance).to receive(:write) do |event|
          expect(event.datetime).to eq Time.now
          expect(event.service).to eq service_name
          expect(event.description).to eq description
          expect(event.message).to eq message
        end
        log_event
      end
    end
  end
end
