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

      config = driver.config
      config["browser_name"].should eq("iOS")
      config["platform"].should eq("Mac")
      config["version"].should eq("6.1")
      config["app"].should eq("/Users/app/path/rufus.app")
    end
 end

  context 'finding elements' do

    let(:mock_driver){double('mock selenium driver')}
    let(:mock_elements){double('mock selenium driver')}

    before(:each) do
      File.stub(:exists?).and_return(true)
      YAML.should_receive(:load_file).with("config.yml").and_return("browser_name" =>"iOS", "platform"=>"Mac", "version"=>"6.1", "app"=>"/Users/app/path/rufus.app")
      @driver = Rufus::Driver.new
    end

    it 'can find an element by name' do
      Selenium::WebDriver.should_receive(:for).and_return(mock_driver)
      mock_driver.should_receive(:find_elements).with(:name, 'rufusButton').and_return(mock_elements)
      mock_elements.should_receive(:[]).with(0)
      @driver.find('rufusButton')
    end

  end
end