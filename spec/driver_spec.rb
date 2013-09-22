require 'spec_helper'
require 'rufus/driver'
require 'yaml'

describe Rufus::Driver do

  let(:selenium){double('Selenium web driver')}

  context 'initializing' do

    let(:yaml){double('YAML loader')}


    before(:each) do
      File.stub(:exists?).and_return(true)
      YAML.should_receive(:load_file).with("config.yml").and_return("browser_name" =>"iOS", "platform"=>"Mac", "version"=>"6.1", "app"=>"/Users/app/path/rufus.app")
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

  context 'dealing with elements' do

    let(:mock_driver){double('mock selenium driver')}
    let(:mock_elements){double('mock selenium driver elements list')}
    let(:mock_element){double('mock selenium driver element')}

    before(:each) do
      File.stub(:exists?).and_return(true)
      YAML.should_receive(:load_file).with("config.yml").and_return("browser_name" =>"iOS", "platform"=>"Mac", "version"=>"6.1", "app"=>"/Users/app/path/rufus.app")

      @driver = Rufus::Driver.new

      Selenium::WebDriver.should_receive(:for).and_return(mock_driver)
      mock_driver.should_receive(:find_element).with(:name, 'rufusButton').and_return(mock_element)
    end

    it 'can find an element by name' do
      @driver.find({:name => 'rufusButton'})
    end

    it 'can click on an element by name' do
      mock_element.should_receive(:click)
      @driver.click({:name =>'rufusButton'})
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

  context 'choosing the url' do

    before(:each) do
      File.stub(:exists?).and_return(true)
      YAML.should_receive(:load_file).with("config.yml").and_return("browser_name" =>"iOS", "platform"=>"Mac", "version"=>"6.1", "app"=>"/Users/app/path/rufus.app")
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
      YAML.should_receive(:load_file).with("config.yml").and_return("browser_name" =>"iOS", "platform"=>"Mac", "version"=>"6.1", "app"=>"/Users/app/path/rufus.app")
      @driver = Rufus::Driver.new
      Selenium::WebDriver.should_receive(:for).and_return(mock_driver)

    end

    it 'can click buttons in sequence' do

      #mock_rufus_button.should_receive(:[]).exactly(20).times.with(0).and_return(mock_rufus_button)
      #mock_rufus_page_button.should_receive(:[]).exactly(10).times.with(0).and_return(mock_rufus_page_button)

      mock_driver.should_receive(:find_element).exactly(20).times.with(:name, 'rufusButton').and_return(mock_rufus_button)
      mock_driver.should_receive(:find_element).exactly(10).times.with(:name, 'rufusPageButton').and_return(mock_rufus_page_button)
      mock_rufus_button.should_receive(:click).exactly(20).times
      mock_rufus_page_button.should_receive(:click).exactly(10).times

      @driver.timed_sequence(['rufusButton', 'rufusPageButton', 'rufusButton'] , 10, 0)

    end
  end
end