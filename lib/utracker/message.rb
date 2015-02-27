require 'multi_json'
require 'securerandom'

class Utracker::Message

  class << self

    private :new

    def pack(payload, parent: nil)
      new(uuid: SecureRandom.uuid, content: payload, parent: parent)
    end

    def unpack(serialized_message)
      hash = MultiJson.load(serialized_message)
      new(uuid: hash['uuid'], content: hash['content'])
    end

  end

  attr_reader :uuid
  attr_reader :parent_uuid
  attr_reader :content

  def initialize(uuid:, content:, parent: nil)
    @uuid = uuid
    @content = content
    @parent = parent
    @parent_uuid = @parent && @parent.uuid
  end

  def log(event)
    Utracker.logger.log(self, event)
  end

  def pack(payload)
    self.class.pack(payload, parent: self)
  end

  def to_json
    MultiJson.dump({
      'uuid' => @uuid,
      'content' => @content,
    })
  end

end
