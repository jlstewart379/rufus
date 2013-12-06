module Rufus
  class Parser

    attr_reader :screen_data

    def initialize(json)
      json = json.gsub('\"','"')
      @screen_data = MultiJson.load(json)
    end

    def class_for(label)
      view_by_label(label)['type'] if found?(label)
    end

    def value(label)
      view_by_label(label)['value'] if found?(label)
    end

    def width(label)
      view_by_label(label)['rect']['size']['width'] if found?(label)
    end

    def height(label)
      view_by_label(label)['rect']['size']['height'] if found?(label)
    end

    def x_pos(label)
      view_by_label(label)['rect']['origin']['x'] if found?(label)
    end

    def y_pos(label)
      view_by_label(label)['rect']['origin']['y'] if found?(label)
    end

    def label_for(label)
      view_by_label(label)['label'] if found?(label)
    end

    def enabled?(label)
      view_by_label(label)['enabled']
    end

    def visible?(label)
      view_by_label(label)['visible']
    end

    def child_count(label)
      view_by_label(label)['children'].count if found(label)
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
      false
      view_by_label(label)['name'].eql?(label) unless view_by_label(label).nil?
    end
  end
end
