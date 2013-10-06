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
      mock_driver.should_receive(:find_element).with(:name, 'rufusButton').and_return(mock_element)
    end

    it 'can find an element by name' do
      @driver.find({:name => 'rufusButton'})
    end

    it 'can click on an element by name' do
      mock_element.should_receive(:click)
      @driver.click({:name =>'rufusButton'})
    end

    it 'can click a button by name only' do
      mock_element.should_receive(:click)
      @driver.press_button 'rufusButton'
    end

    it 'can tell if an element is enabled' do
      mock_element.should_receive(:enabled?).and_return(true)
      @driver.enabled?(:name => 'rufusButton').should be_true
    end

    it 'can tell if an element is displayed on screen' do
      mock_element.should_receive(:displayed?).and_return(true)
      @driver.displayed?(:name => 'rufusButton').should be_true
    end

    it 'can enter text into an element' do
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
  end
end
