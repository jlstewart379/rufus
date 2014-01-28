require 'json'
module Rufus
  class Parser

    attr_reader :screen_data

    def initialize(json)
      @screen_data = JSON.parse(json)
    end

    def class_for(locator)
      find_view(locator)['type'] if exists?(locator)
    end

    def value(locator)
      find_view(locator)['value'] if exists?(locator)
    end

    def width(locator)
      find_view(locator)['rect']['size']['width'] if exists?(locator)
    end

    def height(locator)
      find_view(locator)['rect']['size']['height'] if exists?(locator)
    end

    def x_pos(locator)
      find_view(locator)['rect']['origin']['x'] if exists?(locator)
    end

    def y_pos(locator)
      find_view(locator)['rect']['origin']['y'] if exists?(locator)
    end

    def label_for(locator)
      find_view(locator)['label'] if exists?(locator)
    end

    def enabled?(locator)
      view = find_view(locator)
      return false if view.nil?
      view['enabled']
    end

    def displayed?(locator)
      view = find_view(locator)
      return false if view.nil?
      find_view(locator)['visible']
    end

    def child_count(locator)
      find_view(locator)['children'].count if found(locator)
    end

    def find_view(locator)
      @found_view = nil
      view_data_for(@screen_data, locator)
      @found_view
    end

    def view_data_for(json, locator)
      how = locator.keys[0].to_s
      what = locator[how.to_sym]
      if json[how].eql?(what)
        @found_view = json
      else
        if json['children'].count > 0
          json['children'].each do |child|
            view_data_for(child, locator)
          end
        end
      end
    end

    def exists?(locator)
      if find_view(locator).nil?
        false
      else
        how = locator.keys[0].to_s
        what = locator[how.to_sym]
        find_view(locator)[how].eql?(what)
      end
    end
  end
end
