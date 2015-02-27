lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'thread'
require 'utracker'

BOTS = {
  'alice' => nil,
  'bob' => nil,
  'carl' => nil,
}

class Bot
  attr_accessor :queue

  def initialize(name)
    @name = name
    @queue = Queue.new
  end

  def run
    loop do
      consume_queue
      rest
    end
  end

  def thread
    Thread.current
  end

  private

  def consume_queue
    if @queue.empty?
      if target = others.sample
        message = Utracker::Message.pack("I've got nothing to do...")
        target.queue.push(message.to_json)
        message.log('seeding')
      end
    else
      until @queue.empty?
        serialization = @queue.pop
        handle(serialization)
      end
    end
  end

  def handle(serialization)
    message = Utracker::Message.unpack(serialization)
    message.log('handle')
    reply_to(message)
  end

  def reply_to(message)
    if rand(2) == 0 && (target = others.sample)
      reply = message.pack('Unleash the kraken!')
      target.queue.push(reply.to_json)
      reply.log('reply')
    end
  end

  def others
    BOTS.each_with_object([]) do |(name, bot), list|
      list << bot if bot && name != @name
    end
  end

  def rest
    sleep rand
  end

end

threads = BOTS.keys.map do |name|
  Thread.new do
    Utracker.configure { |config| config[:service_name] = name }
    Bot.new(name).tap do |bot|
      BOTS[name] = bot
      bot.run
    end
  end
end

begin
  threads.each(&:join)
rescue Interrupt
  threads.each(&:terminate)
end
