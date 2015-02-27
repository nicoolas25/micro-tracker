require "utracker/version"

module Utracker
  autoload :Message, 'utracker/message'

  module ModuleMethods
    def config
      @config ||= empty_configuration.freeze
    end

    def configure
      @config = empty_configuration
      yield @config
      @config.freeze
    end

    def logger
    end

    private

    def empty_configuration
      Hash.new do |_, key|
        fail "Missing key '#{key}' in Utracker's configuration."
      end
    end
  end

  extend ModuleMethods
end
