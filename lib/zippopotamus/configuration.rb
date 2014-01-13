module Zippopotamus

  class Configuration

    attr_accessor :use_persistent_connection

    def initialize
      @use_persistent_connection = true
    end


  end


end
