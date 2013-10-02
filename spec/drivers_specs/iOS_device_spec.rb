require 'spec_helper'
require 'rufus/drivers/iOS_device'
require 'selenium-webdriver'


describe Rufus::Drivers::IOS_Device do

  let(:config){ {"browser" =>"iOS", "platform"=>"Mac", "version"=>"6.1", "app"=>"/Users/app/path/rufus.app", "use_physical" => "true"}}
  let(:capabilities){{"browserName" =>"iOS", "platform"=>"Mac", "version"=>"6.1", "app"=>"/Users/app/path/rufus.app"}}
  let(:url){'http://127.0.0.1:4723/wd/hub'}

  context 'initializing driver for iOS device' do
    it 'can create a selenium driver for an iOS device' do
      Selenium::WebDriver.should_receive(:for).with(:remote, :desired_capabilities => capabilities, :url => 'http://127.0.0.1:4723/wd/hub')
      Rufus::Drivers::IOS_Device.for config, url
    end
  end
end