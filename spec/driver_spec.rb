require 'spec_helper'
require 'rufus/driver'
require 'yaml'

describe Rufus::Driver do


  context 'initializing' do

    let(:yaml){double('YAML loader')}

    before(:each) do
      File.stub(:exists?).and_return(true)
      YAML.should_receive(:load).with("config.yml").and_return("browser_name" =>"iOS", "platform"=>"Mac", "version"=>"6.1", "app"=>"/Users/app/path/rufus.app")
    end

    it 'loads the config file' do
      driver = Rufus::Driver.new
      config = driver.config
      config["browser_name"].should eq("iOS")
      config["platform"].should eq("Mac")
      config["version"].should eq("6.1")
      config["app"].should eq("/Users/app/path/rufus.app")
    end


  end
end