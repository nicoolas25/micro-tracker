require 'multi_json'
require 'securerandom'

class Utracker::Message

  class << self

    private :new

    def pack(payload)
      new(uuid: SecureRandom.uuid, content: payload)
    end

    def unpack(serialized_message)
      hash = MultiJson.load(serialized_message)
      new(uuid: hash['uuid'], content: hash['content'])
    end

  end

  attr_reader :uuid
  attr_reader :content

  def initialize(**kwargs)
    @uuid = kwargs[:uuid]
    @content = kwargs[:content]
  end

  def to_json
    MultiJson.dump({
      'uuid' => @uuid,
      'content' => @content,
    })
  end

end
