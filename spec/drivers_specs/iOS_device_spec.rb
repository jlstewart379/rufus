require 'spec_helper'
require 'rufus/drivers/iOS_device'
require 'selenium-webdriver'


describe Rufus::Drivers::IOS_Device do

  let(:config){ {"browser" =>"iOS", "platform"=>"Mac", "version"=>"6.1", "app"=>"/Users/app/path/rufus.app", "use_physical" => "true"}}
  let(:capabilities){{"browserName" =>"iOS", "platform"=>"Mac", "version"=>"6.1", "app"=>"/Users/app/path/rufus.app"}}
  let(:url){'http://127.0.0.1:4723/wd/hub'}
  let(:mock_driver){'mock selenium driver'}

  context 'initializing driver for iOS device' do
    it 'can create a selenium driver for an iOS device' do
      Selenium::WebDriver.should_receive(:for).with(:remote, :desired_capabilities => capabilities, :url => 'http://127.0.0.1:4723/wd/hub')
      Rufus::Drivers::IOS_Device.for config, url
    end
  end

  context 'getting the orientation' do
    it 'can get the current orientation' do
      Selenium::WebDriver.should_receive(:for).with(:remote, :desired_capabilities => capabilities, :url => 'http://127.0.0.1:4723/wd/hub').and_return(mock_driver)
      mock_driver.should_receive(:orientation).and_return(:landscape)
      driver = Rufus::Drivers::IOS_Device.for config, url
      driver.orientation
    end
  end

  context 'setting the orientation' do
    it 'can set a new orientation' do
      Selenium::WebDriver.should_receive(:for).with(:remote, :desired_capabilities => capabilities, :url => 'http://127.0.0.1:4723/wd/hub').and_return(mock_driver)
      mock_driver.should_receive(:rotate).with(:landscape)
      driver = Rufus::Drivers::IOS_Device.for config, url
      driver.rotate :landscape
    end
  end
end