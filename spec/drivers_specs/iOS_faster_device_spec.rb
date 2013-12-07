require 'spec_helper'
require 'rufus/drivers/iOS_faster_device'
require 'rufus/parser'

describe Rufus::Drivers::IOS_FasterDevice do

  let(:config){ {"browser" =>"iOS", "platform"=>"Mac", "version"=>"6.1", "app" =>"/Users/app/path/rufus.app", "use_physical" => "true", "device" => "iPhoneSimulator", "optimized" => true}}
  let(:capabilities){{"browserName" =>"iOS", "platform"=>"Mac", "version"=>"6.1", "app"=>"/Users/app/path/rufus.app"}}
  let(:url){'http://127.0.0.1:4723/wd/hub'}
  let(:mock_driver){'mock selenium driver'}
  let(:driver){Rufus::Drivers::IOS_FasterDevice.new(config)}
  let(:page_data){'mock page source'}
  let(:mock_parser){'a mock rufus parser'}

  before(:each) do
    Selenium::WebDriver.should_receive(:for).with(:remote, :desired_capabilities => capabilities, :url => 'http://127.0.0.1:4723/wd/hub').and_return(mock_driver)
  end
  context 'getting the orientation' do
    it 'can get the current orientation' do
      mock_driver.should_receive(:orientation).and_return(:landscape)
      driver.orientation
    end
  end
  context 'setting the orientation' do
    it 'can set a new orientation' do
      mock_driver.should_receive(:rotate).with(:landscape)
      driver = Rufus::Drivers::IOS_FasterDevice.new(config)
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
          mock_parser.should_receive(:exists?).with('rufusButton').and_return(true)
          driver.exists?(:name => 'rufusButton').should be_true
        end
        it 'can find out if it is not part of things' do
          mock_parser.should_receive(:exists?).with('rufusButton').and_return(false)
          driver.exists?(:name => 'rufusButton').should be_false
        end
      end
      it 'can tell if an element is enabled' do
        mock_parser.should_receive(:enabled?).with('rufusButton').and_return(true)
        driver.enabled?(:name => 'rufusButton').should be_true
      end
      it 'can tell if an element is displayed on screen' do
        mock_parser.should_receive(:displayed?).with('rufusButton').and_return(true)
        driver.displayed?(:name => 'rufusButton').should be_true
      end
      it 'can get the text value of an element' do
        mock_parser.should_receive(:value).with('rufusButton').and_return("whateva")
        driver.text(:name => 'rufusButton').should eq("whateva")
      end
      it 'can get the class of an element in expedited fashion' do
        mock_parser.should_receive(:class_for).with('rufusButton').and_return("UIAButton")
        driver.class(:name => 'rufusButton').should eq("UIAButton")
      end
    end
  end
end
