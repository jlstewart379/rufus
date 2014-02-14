require 'spec_helper'
require 'rufus/drivers/iOS_faster_simulator'
require 'rufus/parser'
require 'selenium-webdriver'


describe Rufus::Drivers::IOS_FasterSimulator do

  let(:config){ {"sim_app_path"=>"/Users/app/path/rufus.app", "use_physical" => "false", "device" => "iPad Simulator", "optimized" => "true"}}
  let(:app){{device: 'iPad Simulator', app_path: '/Users/app/path/rufus.app'}}
  let(:url){'http://127.0.0.1:4723/wd/hub'}
  let(:mock_driver){'mock selenium driver'}
  let(:driver){Rufus::Drivers::IOS_FasterSimulator.new(config)}
  let(:page_data){'mock page source'}
  let(:mock_parser){'a mock rufus parser'}

  before(:each) do
    Appium::Driver.should_receive(:new).with(app).and_return(mock_driver)
    mock_driver.should_receive(:start_driver)
  end
  context 'getting the orientation' do
    it 'can get the current orientation' do
      mock_driver.should_receive(:driver).and_return(mock_driver)
      mock_driver.should_receive(:orientation).and_return(:landscape)
      driver.orientation
    end
  end
  context 'setting the orientation' do
    it 'can set a new orientation' do
      mock_driver.should_receive(:driver).and_return(mock_driver)
      mock_driver.should_receive(:rotate).with(:landscape)
      driver = Rufus::Drivers::IOS_FasterSimulator.new(config)
      driver.rotate :landscape
    end
  end

  context 'dealing with elements' do
    let(:mock_elements){double('mock selenium driver elements list')}
    let(:mock_element){double('mock selenium driver element')}

    context 'finding elements' do
      it 'can find an element by name' do
        mock_driver.should_receive(:find_element).with(:name, 'rufusButton').and_return(mock_element)
        driver.find({:name => 'rufusButton'}).should == mock_element
      end
      it 'can tell if an element does not exist' do
        mock_driver.should_receive(:find_element).with(:name, 'rufusButton').and_raise(Selenium::WebDriver::Error::NoSuchElementError)
        driver.find({:name => 'rufusButton'}).should be_nil
      end
    end
    it 'can click on an element by name' do
      mock_driver.should_receive(:find_element).with(:name, 'rufusButton').and_return(mock_element)
      mock_element.should_receive(:click)
      driver.click({:name =>'rufusButton'})
    end
    it 'can click a button by name only' do
      mock_driver.should_receive(:find_element).with(:name, 'rufusButton').and_return(mock_element)
      mock_element.should_receive(:click)
      driver.press_button 'rufusButton'
    end
    context 'checking read-only elements in expedited fashion' do
      before(:each) do
        mock_driver.should_receive(:page_source).and_return(page_data)
        Rufus::Parser.should_receive(:new).with(page_data).and_return(mock_parser)
      end
      context 'existence' do
        it 'can find out if its part of things' do
          mock_driver.should_receive(:driver).and_return(mock_driver)
          mock_parser.should_receive(:exists?).with(:name => 'rufusButton').and_return(true)
          driver.exists?(:name => 'rufusButton').should be_true
        end
        it 'can find out if it is not part of things' do
          mock_driver.should_receive(:driver).and_return(mock_driver)
          mock_parser.should_receive(:exists?).with(:name => 'rufusButton').and_return(false)
          driver.exists?(:name => 'rufusButton').should be_false
        end
      end
      it 'can tell if an element is enabled' do
        mock_driver.should_receive(:driver).and_return(mock_driver)
        mock_parser.should_receive(:enabled?).with(:name => 'rufusButton').and_return(true)
        driver.enabled?(:name => 'rufusButton').should be_true
    end
      it 'can tell if an element is displayed on screen' do
        mock_driver.should_receive(:driver).and_return(mock_driver)
        mock_parser.should_receive(:displayed?).with(:name => 'rufusButton').and_return(true)
        driver.displayed?(:name => 'rufusButton').should be_true
      end
      it 'can get the text value of an element' do
        mock_driver.should_receive(:driver).and_return(mock_driver)
        mock_parser.should_receive(:value).with(:name => 'rufusButton').and_return("whateva")
        driver.text(:name => 'rufusButton').should eq("whateva")
      end
    end
    it 'can enter text into an element' do
      mock_driver.should_receive(:find_element).with(:name, 'rufusButton').and_return(mock_element)
      mock_element.should_receive(:click)
      mock_element.should_receive(:send_keys).with('text')
      driver.type('text', 'rufusButton')
    end
    context 'locator does not contain name key' do
      it 'calls the super class implementation for exists?' do
        mock_driver.should_receive(:find_element).with(:xpath, 'rufusButton')
        driver.exists?(:xpath => 'rufusButton')
      end
      it 'calls the super class implementation for enabled?' do
        mock_driver.should_receive(:find_element).with(:xpath, 'rufusButton').and_return(mock_element)
        mock_element.should_receive(:enabled?)
        driver.enabled?(:xpath => 'rufusButton')
      end
      it 'calls the super class implementation for displayed?' do
        mock_driver.should_receive(:find_element).with(:xpath, 'rufusButton').and_return(mock_element)
        mock_element.should_receive(:displayed?)
        driver.displayed?(:xpath => 'rufusButton')
      end

      it 'can get the class of an element' do
        mock_parser = 'a mock parser'
        mock_page_source = 'some page source'
        mock_driver.should_receive(:driver).and_return(mock_driver)
        mock_driver.should_receive(:page_source).and_return(mock_page_source)
        view_data = {"name"=>"Rufus Label", "type"=>"UIAStaticText", "label"=>"Rufus Label", "value"=>"Rufus Label", "rect"=>{"origin"=>{"x"=>333, "y"=>153}, "size"=>{"width"=>92, "height"=>21}}, "dom"=>nil, "enabled"=>true, "valid"=>true, "visible"=>true, "children"=>[], "hint"=>nil}
        Rufus::Parser.should_receive(:new).with(mock_page_source).and_return(mock_parser)
        mock_parser.should_receive(:find_view).with(:name => 'rufusLabel').and_return(view_data)
        driver.class(:name => 'rufusLabel').should eq('UIAStaticText')
      end

      context 'locator contains label key' do
        it 'should use the parser to generate a locator that uses the name' do
          mock_driver.should_receive(:driver).and_return(mock_driver)
          mock_driver.should_receive(:page_source).and_return(page_data)
          mock_driver.should_receive(:find_element).with(:name, 'showAlertButton')
          view_data =  {"name"=>"showAlertButton", "type"=>"UIAButton", "label"=>"showAlertButton", "value"=>nil, "rect"=>{"origin"=>{"x"=>304, "y"=>302}, "size"=>{"width"=>150, "height"=>30}}, "dom"=>nil, "enabled"=>true, "valid"=>true, "visible"=>true, "children"=>[]}
          Rufus::Parser.should_receive(:new).with(page_data).and_return(mock_parser)
          mock_parser.should_receive(:find_view).with(:label => 'rufusLabel').and_return(view_data)
          driver.find(:label => 'rufusLabel')
        end
      end
    end
  end
end