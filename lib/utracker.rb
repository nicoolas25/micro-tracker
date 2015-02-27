require "utracker/version"

module Utracker
  autoload :Message, 'utracker/message'

  module ModuleMethods
    def logger
    end
  end

  extend ModuleMethods
end
