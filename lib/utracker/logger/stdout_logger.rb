require 'multi_json'

class Utracker::StdoutLogger < Utracker::Logger

  protected

  def write(event, options)
    {
      datetime: event.datetime.to_s,
      service: event.service,
      description: event.description,
      uuid: event.message.uuid,
      parent_uuid: event.message.parent_uuid,
    }.tap do |hash|
      hash[:payload] = event.message.content unless options[:hide_payload]
      STDOUT.puts MultiJson.dump(hash)
    end
  end

end
