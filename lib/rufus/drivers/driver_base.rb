module Rufus
  module Drivers
    class DriverBase

      def capabilities; raise Exception; end

      def start
        selenium.get url
      end

      def quit
        selenium.quit
        @selenium_driver = nil
      end

      def server_url
        @url
      end

      def find(locator)
        how = locator.keys[0].to_sym
        what = locator[how]
        begin
          selenium.find_element(how, what)
        rescue Selenium::WebDriver::Error::NoSuchElementError
          return nil
        end
      end

      def cells(locator)
        element = find(locator)
        raise 'Expected view to be of type UIATableView' unless element.tag_name.eql? 'UIATableView'
        element.find_elements(:tag_name, 'UIATableCell')
      end

      def click(locator)
        find(locator).click
      end

      def press_button name
        click(:name => name)
      end

      def enabled?(locator)
        find(locator).enabled?
      end

      def displayed?(locator)
        find(locator).displayed?
      end

      def text(locator)
        find(locator).text
      end

      def class(locator)
        find(locator).tag_name
      end

      def orientation
        selenium.orientation.to_s
      end

      def rotate(orientation)
        selenium.rotate orientation
      end

      def type(keys, name)
        element = find(:name => name)
        element.click
        sleep 1
        element.send_keys keys
      end

      def sequence(*names, times)
        timed_sequence(names, times, 1)
      end

      def buttons
        buttons = []
        elements = elements_by_tag 'UIAButton'
        elements.each do |element|
          buttons << element.text
        end
        buttons
      end

      def text_fields
        fields = []
        elements = elements_by_tag 'UIATextField'
        elements.each do |element|
          fields << element.text
        end
        fields
      end

      def labels
        labels = []
        elements = elements_by_tag 'UIAStaticText'
        elements.each do |element|
          labels << element.text
        end
        labels
      end

      def timed_sequence(names, times, seconds)
        current = 0
        until current == times
          names.each do |name|
            click(:name => name)
            sleep seconds

          end
          current += 1
          puts "sequence #{current} completed"
        end
      end

      def find_alert(locator)
        alert = nil
        all_elements.each do |element|
          if is_alert?(element)
            alert = element if match?(element, locator[:name])
          end
        end
        alert
      end

      def click_alert(button)
        if alert_shown?
          click_alert_button(button)
        end
      end

      def alert_shown?
        all_elements.each do |element|
          if is_alert?(element)
            return true
          end
        end
        false
      end

      def class_for(element)
        element.tag_name
      end

      def match?(element, name)
        element.attribute(:name).eql? name
      end

      def page_source
        selenium.page_source
      end

      def all_elements
        elements_by_tag('UIAElement')
      end

      def elements_by_tag(name)
        selenium.find_elements(:tag_name, name)
      end

      def scroll_to(locator)
        id = find(locator).ref
        selenium.execute_script 'mobile: scrollTo', {'element' => id}
      end

      def screenshot(name)
        selenium.save_screenshot name
      end

      private

      def url
        'http://127.0.0.1:4723/wd/hub'
      end

      def click_alert_button(button)
        all_elements.each do |element|
          element.click if is_table_view_cell?(element) && match?(element, button)
        end
      end

      def is_alert?(element)
        class_for(element).eql?('UIAAlert')
      end

      def is_table_view_cell?(element)
        class_for(element).eql?('UIATableCell')
      end

      def selenium
        @selenium_driver ||= Selenium::WebDriver.for(:remote, :desired_capabilities => capabilities, :url => url)
      end
    end
  end
end