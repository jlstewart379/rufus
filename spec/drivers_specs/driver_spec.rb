require 'spec_helper'
require 'rufus/driver'
require 'rufus/drivers/driver_factory'
require 'yaml'

describe Rufus::Driver do

  let(:selenium){double('Selenium web driver')}

  context 'initializing' do

    let(:yaml){double('YAML loader')}

    context 'config file exists' do
      let(:mock_driver){'driver returned from factory'}
      before(:each) do
        File.stub(:exists?).and_return(true)
        YAML.should_receive(:load).and_return("browser_name" =>"iOS", "platform"=>"Mac", "version"=>"6.1", "app"=>"/Users/app/path/rufus.app")
        Rufus::Drivers::DriverFactory.should_receive(:driver_for).and_return(mock_driver)
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
end

