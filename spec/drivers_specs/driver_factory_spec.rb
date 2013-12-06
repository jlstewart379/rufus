require 'spec_helper'
require 'rufus/drivers/driver_factory'
require 'rufus/drivers/iOS_device'
require 'rufus/drivers/iOS_faster_device'

describe Rufus::Drivers::DriverFactory do

  let(:url){'http://192.168.1.1'}

  context 'getting regular old iOS device driver' do
    let(:iOS_physical_config){ {"browser" =>"iOS", "platform"=>"Mac", "version"=>"6.1", "app"=>"/Users/app/path/rufus.app", "use_physical" => true}}

    it 'creates an instance of a regular a non-optimized iOS driver for physical device' do
      Rufus::Drivers::IOS_Device.should_receive(:for).with(iOS_physical_config, url)
      @driver = Rufus::Drivers::DriverFactory.driver_for(iOS_physical_config, url)
      @driver.kind_of?(Rufus::Drivers::IOS_Device)
    end

  context 'getting an optimized iOS driver for physical device'

    let(:iOS_physical_optimized){{"browser" =>"iOS", "platform"=>"Mac", "version"=>"6.1", "app"=>"/Users/app/path/rufus.app", "use_physical" => true, "read_page_source" => true}}

    it 'creates an instance of an optimized iOS driver for a physical device' do
      Rufus::Drivers::IOS_FasterDevice.should_receive(:for).with(iOS_physical_optimized, url)
      @driver = Rufus::Drivers::DriverFactory.driver_for(iOS_physical_optimized, url)
      @driver.kind_of?(Rufus::Drivers::IOS_FasterDevice)
    end

  end
end

