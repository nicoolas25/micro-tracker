require "utracker/version"

module Utracker

  autoload :Logger,       'utracker/logger'
  autoload :StdoutLogger, 'utracker/logger/stdout_logger'

  autoload :Message, 'utracker/message'

  module ModuleMethods
    def config
      @config ||= default_configuration.freeze
    end

    def configure
      @config = default_configuration
      yield @config
      @logger = nil
      @config.freeze
    end

    def logger
      @logger ||= config[:logger_class].new
    end

    private

    def default_configuration
      Hash.new{ |_, key| fail "Missing key '#{key}' in Utracker's configuration." }.tap do |hash|
        hash[:logger_class] = Utracker::StdoutLogger
      end
    end
  end

  extend ModuleMethods

end
