require 'multi_json'
require 'securerandom'

class Utracker::Message

  class << self

    private :new

    def pack(payload, parent_uuid: nil)
      new(uuid: SecureRandom.uuid, content: payload, parent_uuid: parent_uuid)
    end

    def unpack(serialized_message)
      hash = MultiJson.load(serialized_message)
      new(uuid: hash['uuid'],
          content: hash['content'],
          parent_uuid: hash['parent_uuid'])
    end

  end

  attr_reader :uuid
  attr_reader :parent_uuid
  attr_reader :content

  def initialize(uuid:, content:, parent_uuid: nil)
    @uuid = uuid
    @content = content
    @parent_uuid = parent_uuid
  end

  def log(event)
    Utracker.logger.log(self, event)
  end

  def pack(payload)
    self.class.pack(payload, parent_uuid: @uuid)
  end

  def to_json
    MultiJson.dump({
      'uuid' => @uuid,
      'parent_uuid' => @parent_uuid,
      'content' => @content,
    })
  end

end
