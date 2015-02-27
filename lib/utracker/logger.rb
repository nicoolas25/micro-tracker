class Utracker::Logger

  Event = Struct.new(:datetime, :service, :description, :message)

  def log(message, description)
    write Event.new(
      Time.now,
      Utracker.config[:service_name],
      description,
      message
    )
  end

  protected

  def write(event)
    fail 'Please implement me in subclasses.'
  end

end
