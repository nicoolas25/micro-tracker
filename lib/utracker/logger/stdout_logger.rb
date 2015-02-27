require 'multi_json'

class Utracker::StdoutLogger < Utracker::Logger

  protected

  def write(event)
    puts [
      event.datetime.to_s,
      event.service,
      event.description,
      event.message.uuid,
      serialized_content(event.message.content),
    ].join(' ; ')
  end

  def serialized_content(content)
    case content
    when String then content
    when Hash, Array then MultiJson.dump(content)
    else fail "Message content of type '#{content.class}' are not supported."
    end
  end

end
