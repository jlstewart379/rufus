require 'spec_helper'
require 'rufus/drivers/iOS_Simulator'
require 'selenium-webdriver'

describe Rufus::Drivers::IOS_Simulator do

  let(:config){ {"browser" =>"iOS", "platform"=>"Mac", "version"=>"6.1", "app"=>"/Users/app/path/rufus.app", "use_physical" => "true", "sim_app_path" => "/path/to/simulator.app"}}
  let(:capabilities){{"browserName" =>"iOS", "platform"=>"Mac", "version"=>"6.1", "app"=>"/path/to/simulator.app", "device" => "iPhoneSimulator"}}
  let(:url){'http://127.0.0.1:4723/wd/hub'}

  context 'initializing driver for iOS device' do
    it 'can create a selenium driver for an iOS device' do
      Selenium::WebDriver.should_receive(:for).with(:remote, :desired_capabilities => capabilities, :url => 'http://127.0.0.1:4723/wd/hub')
      Rufus::Drivers::IOS_Simulator.for config, url
    end
  end
end