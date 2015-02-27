class Utracker::StdoutLogger < Utracker::Logger

  protected

  def write(event)
    puts [
      event.datetime.to_s,
      event.service,
      event.description,
      event.message.uuid,
    ].join(' ; ')
  end

end
