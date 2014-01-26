require 'json'
module Rufus
  class Parser

    attr_reader :screen_data

    def initialize(json)
      @screen_data = JSON.parse(json)
    end

    def class_for(label)
      view_by_label(label)['type'] if exists?(label)
    end

    def value(label)
      view_by_label(label)['value'] if exists?(label)
    end

    def width(label)
      view_by_label(label)['rect']['size']['width'] if exists?(label)
    end

    def height(label)
      view_by_label(label)['rect']['size']['height'] if exists?(label)
    end

    def x_pos(label)
      view_by_label(label)['rect']['origin']['x'] if exists?(label)
    end

    def y_pos(label)
      view_by_label(label)['rect']['origin']['y'] if exists?(label)
    end

    def label_for(label)
      view_by_label(label)['label'] if exists?(label)
    end

    def enabled?(label)
      view = view_by_label(label)
      return false if view.nil?
      view['enabled']
    end

    def displayed?(label)
      view = view_by_label(label)
      return false if view.nil?
      view_by_label(label)['visible']
    end

    def child_count(label)
      view_by_label(label)['children'].count if found(label)
    end

    def view_by_label(locator)
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
      if view_by_label(locator).nil?
        false
      else
        how = locator.keys[0].to_s
        what = locator[how.to_sym]
        view_by_label(locator)[how].eql?(what)
      end
    end
  end
end
