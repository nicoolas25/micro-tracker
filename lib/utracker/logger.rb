class Utracker::Logger

  Event = Struct.new(:datetime, :service, :description, :message)

  def log(message, description, options={})
    event = Event.new(
      Time.now,
      Utracker.config[:service_name],
      description,
      message
    )
    write(event, options)
  end

  protected

  def write(event, options)
    fail 'Please implement me in subclasses.'
  end

end
