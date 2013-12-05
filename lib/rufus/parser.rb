module Rufus
  class Parser

    attr_reader :screen_data

    def initialize(json)
      json = json.gsub('\"','"')
      @screen_data = MultiJson.load(json)
    end

    private
    def strip_escapes(json)
      json.gsub
    end



  end
end
