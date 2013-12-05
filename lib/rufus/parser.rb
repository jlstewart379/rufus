module Rufus
  class Parser

    attr_reader :screen_data

    def initialize(json)
      @screen_data = MultiJson.load(json)
    end



  end
end
