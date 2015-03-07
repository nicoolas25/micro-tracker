class Utracker::Logger

  Event = Struct.new(:datetime, :service, :description, :message, :options) do
    def payload
      return if options[:hide_payload]
      Utracker.config[:formatter][message.content]
    end
  end

  def log(message, description, options={})
    event = Event.new(
      Time.now,
      Utracker.config[:service_name],
      description,
      message,
      options
    )
    write(event)
  end

  protected

  def write(event)
    fail 'Please implement me in subclasses.'
  end

end
