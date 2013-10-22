require 'spec_helper'
require 'rufus/driver'
require 'rufus/drivers/iOS_device'
require 'rufus/drivers/iOS_simulator'
require 'yaml'

describe Rufus::Driver do

  let(:selenium){double('Selenium web driver')}

  context 'initializing' do

    let(:yaml){double('YAML loader')}

    context 'config file exists' do
      before(:each) do
        File.stub(:exists?).and_return(true)
        YAML.should_receive(:load).and_return("browser_name" =>"iOS", "platform"=>"Mac", "version"=>"6.1", "app"=>"/Users/app/path/rufus.app")
        @driver = Rufus::Driver.new
      end
      it 'loads the config file' do
        config = @driver.config
        config["browser_name"].should eq("iOS")
        config["platform"].should eq("Mac")
        config["version"].should eq("6.1")
        config["app"].should eq("/Users/app/path/rufus.app")
      end
    end
    context 'config file does not exists' do

      before(:each) do
        File.stub(:exists?).and_return(false)
      end

      it 'raises an exception if no config found' do

        expect{Rufus::Driver.new}.to raise_error(RuntimeError, 'No config.yml found')
      end
    end
 end

  context 'dealing with elements' do

    let(:mock_driver){double('mock selenium driver')}
    let(:mock_elements){double('mock selenium driver elements list')}
    let(:mock_element){double('mock selenium driver element')}


    before(:each) do
      File.stub(:exists?).and_return(true)
      YAML.should_receive(:load).and_return("browser_name" =>"iOS", "platform"=>"Mac", "version"=>"6.1", "app"=>"/Users/app/path/rufus.app")
      @driver = Rufus::Driver.new
      Rufus::Drivers::IOS_Simulator.should_receive(:for).and_return(mock_driver)
    end

    context 'finding elements' do

      it 'can find an element by name' do
        mock_driver.should_receive(:find_element).with(:name, 'rufusButton').and_return(mock_element)
        @driver.find({:name => 'rufusButton'}).should == mock_element
      end

      it 'can tell if an element does not exist' do
        mock_driver.should_receive(:find_element).with(:name, 'rufusButton').and_raise(Selenium::WebDriver::Error::NoSuchElementError)
        @driver.find({:name => 'rufusButton'}).should be_nil
      end
    end

    it 'can click on an element by name' do
      mock_driver.should_receive(:find_element).with(:name, 'rufusButton').and_return(mock_element)
      mock_element.should_receive(:click)
      @driver.click({:name =>'rufusButton'})
    end

    it 'can click a button by name only' do
      mock_driver.should_receive(:find_element).with(:name, 'rufusButton').and_return(mock_element)
      mock_element.should_receive(:click)
      @driver.press_button 'rufusButton'
    end

    it 'can tell if an element is enabled' do
      mock_driver.should_receive(:find_element).with(:name, 'rufusButton').and_return(mock_element)
      mock_element.should_receive(:enabled?).and_return(true)
      @driver.enabled?(:name => 'rufusButton').should be_true
    end

    it 'can tell if an element is displayed on screen' do
      mock_driver.should_receive(:find_element).with(:name, 'rufusButton').and_return(mock_element)
      mock_element.should_receive(:displayed?).and_return(true)
      @driver.displayed?(:name => 'rufusButton').should be_true
    end

    it 'can enter text into an element' do
      mock_driver.should_receive(:find_element).with(:name, 'rufusButton').and_return(mock_element)
      mock_element.should_receive(:click)
      mock_element.should_receive(:send_keys).with('text')
      @driver.type('text', 'rufusButton')
    end
  end

  context 'finding all elements of a type' do

    let(:mock_driver){double('mock selenium driver')}
    let(:mock1){double('first mock element')}
    let(:mock2){double('second mock element')}
    let(:mock3){double('third mock element')}

    before(:each) do
      File.stub(:exists?).and_return(true)
      YAML.should_receive(:load).and_return("browser_name" =>"iOS", "platform"=>"Mac", "version"=>"6.1", "app"=>"/Users/app/path/rufus.app")

      @test_driver = Rufus::Driver.new

     Rufus::Drivers::IOS_Simulator.should_receive(:for).and_return(mock_driver)

    end

    it 'can find all button elements on the screen' do
      mock_driver.should_receive(:find_elements).with(:tag_name, 'UIAButton').and_return([mock1, mock2, mock3])
      mock1.should_receive(:text).and_return("one")
      mock2.should_receive(:text).and_return("two")
      mock3.should_receive(:text).and_return("three")
      @test_driver.buttons.should == ["one", "two", "three"]
    end

    it 'can find all text field elements on the screen' do
      mock_driver.should_receive(:find_elements).with(:tag_name, 'UIATextField').and_return([mock1, mock2, mock3])
      mock1.should_receive(:text).and_return("one")
      mock2.should_receive(:text).and_return("two")
      mock3.should_receive(:text).and_return("three")
      @test_driver.text_fields.should == ["one", "two", "three"]
    end

    it 'can find all labels on the screen' do
      mock_driver.should_receive(:find_elements).with(:tag_name, 'UIAStaticText').and_return([mock1, mock2, mock3])
      mock1.should_receive(:text).and_return("one")
      mock2.should_receive(:text).and_return("two")
      mock3.should_receive(:text).and_return("three")
      @test_driver.labels.should == ["one", "two", "three"]
    end
  end

  context 'choosing the url' do
    before(:each) do
      File.stub(:exists?).and_return(true)
      YAML.should_receive(:load).and_return("browser_name" =>"iOS", "platform"=>"Mac", "version"=>"6.1", "app"=>"/Users/app/path/rufus.app")
      @driver = Rufus::Driver.new
    end
    it 'sets the default url' do
      @driver.server_url.should eq 'http://127.0.0.1:4723/wd/hub'
    end
  end

  context 'executing button sequences' do

    let(:mock_driver){double('mock selenium driver')}
    let(:mock_rufus_button){double('Mock rufus button')}
    let(:mock_rufus_page_button){double('mock selenium driver element')}

    before(:each) do
      File.stub(:exists?).and_return(true)
      YAML.should_receive(:load).and_return("browser_name" =>"iOS", "platform"=>"Mac", "version"=>"6.1", "app"=>"/Users/app/path/rufus.app")
      @driver = Rufus::Driver.new
      Rufus::Drivers::IOS_Simulator.should_receive(:for).and_return(mock_driver)
    end

    it 'can click buttons in sequence' do
      mock_driver.should_receive(:find_element).exactly(20).times.with(:name, 'rufusButton').and_return(mock_rufus_button)
      mock_driver.should_receive(:find_element).exactly(10).times.with(:name, 'rufusPageButton').and_return(mock_rufus_page_button)
      mock_rufus_button.should_receive(:click).exactly(20).times
      mock_rufus_page_button.should_receive(:click).exactly(10).times
      @driver.timed_sequence(['rufusButton', 'rufusPageButton', 'rufusButton'] , 10, 0)

    end
  end

  context 'finding alerts' do

    let(:mock_driver){double('mock selenium driver')}
    let(:mock_alert){double('mock alert view')}
    let(:mock_elements){double('mock elements')}
    let(:mock_element){double('mock element')}

    before(:each) do
      File.stub(:exists?).and_return(true)
      YAML.should_receive(:load).and_return("browser_name" =>"iOS", "platform"=>"Mac", "version"=>"6.1", "app"=>"/Users/app/path/rufus.app")
      @driver = Rufus::Driver.new
      Rufus::Drivers::IOS_Simulator..should_receive(:for).and_return(mock_driver)
    end
  end

  context 'searching elements' do
    let(:mock_element){double('mock element')}
    let(:mock_driver){double('mock selenium driver')}

    before(:each) do
      File.stub(:exists?).and_return(true)
      YAML.should_receive(:load).and_return("browser_name" =>"iOS", "platform"=>"Mac", "version"=>"6.1", "app"=>"/Users/app/path/rufus.app")
      @driver = Rufus::Driver.new
    end

    it 'can find the class for an element' do
      mock_element.should_receive(:tag_name).and_return('UIAAlert')
      @driver.class_for(mock_element).should eq('UIAAlert')
    end

    context 'matching elements by name' do
      it 'returns true if element matches' do
        mock_element.should_receive(:attribute).with(:name).and_return('Rufus Alert')
        @driver.match?(mock_element, 'Rufus Alert').should be_true
      end
      it 'returns false if element does not match' do
        mock_element.should_receive(:attribute).with(:name).and_return('Some other alert title')
        @driver.match?(mock_element, 'Rufus Alert').should be_false
      end
    end

    context 'clicking alert view buttons' do

      let(:mock_element){double{'mock element'}}
      let(:mock_driver){double('mock selenium driver')}

      before(:each) do
        File.stub(:exists?).and_return(true)
        YAML.should_receive(:load).and_return("browser_name" =>"iOS", "platform"=>"Mac", "version"=>"6.1", "app"=>"/Users/app/path/rufus.app")
        @driver = Rufus::Driver.new

      end

      it 'can tell if an alert is in the view hierarchy' do
        mock_element.should_receive(:tag_name).and_return('UIAAlert')
        @driver.send(:is_alert?, mock_element).should be_true
      end
      it 'can tell if an alert is not in the view hierarchy' do
        mock_element.should_receive(:tag_name).and_return('SomeOtherClass')
        @driver.send(:is_alert?, mock_element).should be_false
      end

      it 'can tell if a table cell is in the view hierarchy' do
        mock_element.should_receive(:tag_name).and_return('UIATableCell')
        @driver.send(:is_table_view_cell?, mock_element).should be_true
      end

      it 'can click an alert button' do
        mock_driver.should_receive(:find_elements).at_least(2).times.with(:tag_name, 'UIAElement').and_return([mock_element])
        Rufus::Drivers::IOS_Simulator.should_receive(:for).and_return(mock_driver)
        mock_element.should_receive(:tag_name).at_least(2).times.and_return('UIAAlert')
        @driver.click_alert('Ok')
      end
    end


    context 'starting drivers' do

      let(:yaml){double('YAML loader')}
      let(:mock_driver){'a mock app driver'}
      let(:url){'http://127.0.0.1:4723/wd/hub'}

      context 'starting iOS device driver' do
        before(:each) do
          File.stub(:exists?).and_return(true)
          @config = {"browser_name" =>"iOS", "platform"=>"Mac", "version"=>"6.1", "app"=>"/Users/app/path/rufus.app", "use_physical" => true}
          YAML.should_receive(:load).and_return(@config)
          @driver = Rufus::Driver.new
        end

        it 'can start the driver for an iOS device' do
            Rufus::Drivers::IOS_Device.should_receive(:for).with(@config, url).and_return(mock_driver)
            mock_driver.should_receive(:get)
            @driver.start
        end
      end

      context 'starting iOS simulator driver' do
        before(:each) do
          File.stub(:exists?).and_return(true)
          @config = {"browser_name" =>"iOS", "platform"=>"Mac", "version"=>"6.1", "app"=>"/Users/app/path/rufus.app", "use_physical" => false}
          YAML.should_receive(:load).and_return(@config)
          @driver = Rufus::Driver.new
        end

        it 'can start the driver for an iOS simulator' do
          Rufus::Drivers::IOS_Simulator.should_receive(:for).with(@config, url).and_return(mock_driver)
          mock_driver.should_receive(:get)
          @driver.start
        end
      end
    end
    context 'verifying and setting device orientation' do

      let(:yaml){double('YAML loader')}
      let(:mock_driver){'a mock app driver'}
      let(:url){'http://127.0.0.1:4723/wd/hub'}

      context 'orientation' do

        before(:each) do
          File.stub(:exists?).and_return(true)
          @config = {"browser_name" =>"iOS", "platform"=>"Mac", "version"=>"6.1", "app"=>"/Users/app/path/rufus.app", "use_physical" => false}
          YAML.should_receive(:load).and_return(@config)
          @driver = Rufus::Driver.new
        end

        it 'can get the device orientation in landscape' do
          Rufus::Drivers::IOS_Simulator.should_receive(:for).with(@config, url).and_return(mock_driver)
          mock_driver.should_receive(:orientation).and_return(:landscape)
          @driver.orientation.should eq('landscape')
        end

        it 'can set the device orientation to portrait' do

          Rufus::Drivers::IOS_Simulator.should_receive(:for).with(@config, url).and_return(mock_driver)
          mock_driver.should_receive(:rotate).with('portrait')
          @driver.rotate('portrait')
        end
      end
    end

    context 'getting the page data' do

      let(:yaml){double('YAML loader')}
      let(:mock_driver){'a mock app driver'}
      let(:url){'http://127.0.0.1:4723/wd/hub'}

      before(:each) do
        File.stub(:exists?).and_return(true)
        @config = {"browser_name" =>"iOS", "platform"=>"Mac", "version"=>"6.1", "app"=>"/Users/app/path/rufus.app", "use_physical" => false}
        YAML.should_receive(:load).and_return(@config)
        @driver = Rufus::Driver.new
      end

      it 'can get all the page data' do

        Rufus::Drivers::IOS_Simulator.should_receive(:for).with(@config, url).and_return(mock_driver)
        mock_driver.should_receive(:page_source).and_return("some page data")
        @driver.page_source.should eq("some page data")
      end

      context 'getting element lists by class' do

        let(:mock_list){'a mock list of elements'}

        before(:each) do
          Rufus::Drivers::IOS_Simulator.should_receive(:for).with(@config, url).and_return(mock_driver)
        end

        it 'can get all the buttons' do
          mock_driver.should_receive(:find_elements).with(:tag_name, 'UIAButton').and_return(mock_list)
          @driver.elements_by_tag('UIAButton').should eq(mock_list)
        end
      end
    end
    context 'scrolling' do

      let(:yaml){double('YAML loader')}
      let(:mock_driver){'a mock app driver'}
      let(:url){'http://127.0.0.1:4723/wd/hub'}
      let(:mock_element){'mock selenium element'}
      let(:swipe_options){{'element' => 1}}
      before(:each) do
        File.stub(:exists?).and_return(true)
        @config = {"browser_name" =>"iOS", "platform"=>"Mac", "version"=>"6.1", "app"=>"/Users/app/path/rufus.app", "use_physical" => false}
        YAML.should_receive(:load).and_return(@config)
        @driver = Rufus::Driver.new
      end

      it 'can scroll to a view' do
        Rufus::Drivers::IOS_Simulator.should_receive(:for).with(@config, url).and_return(mock_driver)
        mock_driver.should_receive(:find_element).with(:name, 'elementName').and_return(mock_element)
        mock_element.should_receive(:ref).and_return(1)
        mock_driver.should_receive(:execute_script).with('mobile: scrollTo', swipe_options)
        @driver.scroll_to(:name => 'elementName')
      end
    end

    context 'finding child elements of table view' do

      let(:yaml){double('YAML loader')}
      let(:mock_driver){'a mock app driver'}
      let(:url){'http://127.0.0.1:4723/wd/hub'}
      let(:mock_element){'mock selenium element'}
      let(:children){'mock tableview children'}

      before(:each) do
        File.stub(:exists?).and_return(true)
        @config = {"browser_name" =>"iOS", "platform"=>"Mac", "version"=>"6.1", "app"=>"/Users/app/path/rufus.app", "use_physical" => false}
        YAML.should_receive(:load).and_return(@config)
        @driver = Rufus::Driver.new
        Rufus::Drivers::IOS_Simulator.should_receive(:for).with(@config, url).and_return(mock_driver)
        mock_driver.should_receive(:find_element).with(:name, 'elementName').and_return(mock_element)
      end

      it 'returns no elements if element is not table view' do
        mock_element.should_receive(:tag_name).and_return('UIStaticText')
        expect{@driver.cells(:name => 'elementName')}.to raise_error(RuntimeError, 'Expected view to be of type UIATableView')
      end

      it 'can find a list of child elements' do
        mock_element.should_receive(:tag_name).and_return('UIATableView')
        mock_element.should_receive(:find_elements).with(:tag_name, 'UIATableCell').and_return(children)
        @driver.cells(:name => 'elementName').should == children
      end
    end
  end
end

