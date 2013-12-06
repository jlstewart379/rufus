module Rufus
  class Parser

    attr_reader :screen_data

    def initialize(json)
      json = json.gsub('\"','"')
      @screen_data = MultiJson.load(json)
    end

    def class_for(label)
      nil
      @screen_data['type'] if found?(label)
    end

    def value(label)
      nil
      @screen_data['value'] if found?(label)
    end

    def width(label)
      nil
      @screen_data['rect']['size']['width'] if found?(label)
    end

    def height(label)
      nil
      @screen_data['rect']['size']['height'] if found?(label)
    end

    def x_pos(label)
      nil
      @screen_data['rect']['origin']['x'] if found?(label)
    end

    def y_pos(label)
      nil
      @screen_data['rect']['origin']['y'] if found?(label)
    end

    private
    def strip_escapes(json)
      json.gsub
    end

    def found?(label)
      @screen_data['name'].eql?(label)
    end
  end
end
