module Rufus
  class Parser

    attr_reader :screen_data

    def initialize(json)
      json = json.gsub('\"','"')
      @screen_data = MultiJson.load(json)
    end

    def class_for(label)
      @screen_data['type'] if found?(label)
    end

    def value(label)
      @screen_data['value'] if found?(label)
    end

    def width(label)
      @screen_data['rect']['size']['width'] if found?(label)
    end

    def height(label)
      @screen_data['rect']['size']['height'] if found?(label)
    end

    def x_pos(label)
      @screen_data['rect']['origin']['x'] if found?(label)
    end

    def y_pos(label)
      @screen_data['rect']['origin']['y'] if found?(label)
    end

    def enabled?(label)
      @screen_data['enabled']
    end

    def visible?(label)
      @screen_data['visible']
    end

    def child_count(label)
      @screen_data['children'].count if found(label)
    end

    def view_by_label(label)
      @found_view = nil
      view_data_for(@screen_data, label)
      @found_view
    end

    def view_data_for(json, label)
      if json['name'].eql?(label)
        @found_view = json
      else
        if json['children'].count > 0
          json['children'].each do |child|
            view_data_for(child, label)
          end
        end
      end
    end

    private



    def found?(label)
      @screen_data['name'].eql?(label)
    end
  end
end
