require "case_any/version"
require 'singleton'

module Kernel
  class AnyClass
    include Singleton
    def ==(_)
      true
    end
    def ===(_)
      true
    end
  end
  def any
    AnyClass.instance
  end
end

