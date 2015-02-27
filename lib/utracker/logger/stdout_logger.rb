require 'multi_json'

class Utracker::StdoutLogger < Utracker::Logger

  protected

  def write(event)
    STDOUT.puts MultiJson.dump({
      datetime: event.datetime.to_s,
      service: event.service,
      description: event.description,
      uuid: event.message.uuid,
      parent_uuid: event.message.parent_uuid,
      payload: event.message.content,
    })
  end

end
