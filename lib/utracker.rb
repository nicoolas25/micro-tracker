require "utracker/version"

module Utracker

  autoload :Logger,       'utracker/logger'
  autoload :StdoutLogger, 'utracker/logger/stdout_logger'

  autoload :Message, 'utracker/message'

  DEFAULT_FORMATTER = ->(payload){ payload }

  module ModuleMethods

    def config
      Thread.current[:utracker_config] ||= default_configuration.freeze
    end

    def logger
      Thread.current[:utracker_logger] ||= config[:logger_class].new
    end

    def configure
      self.config = default_configuration
      yield config
      self.logger = nil
      self.config.freeze
    end

    private

    def config=(new_config)
      Thread.current[:utracker_config] = new_config
    end

    def logger=(new_logger)
      Thread.current[:utracker_logger] = new_logger
    end

    def default_configuration
      Hash.new{ |_, key| fail "Missing key '#{key}' in Utracker's configuration." }.tap do |hash|
        hash[:logger_class] = Utracker::StdoutLogger
        hash[:formatter] = DEFAULT_FORMATTER
      end
    end

  end

  extend ModuleMethods

end
