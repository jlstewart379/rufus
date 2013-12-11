require 'spec_helper'
require 'rufus/drivers/driver_factory'
require 'rufus/drivers/iOS_device'
require 'rufus/drivers/iOS_simulator'
require 'rufus/drivers/iOS_faster_device'

describe Rufus::Drivers::DriverFactory do

  let(:url){'http://192.168.1.1'}
  context 'getting regular old iOS device driver' do
    let(:iOS_physical_config){ {"browser" =>"iOS", "platform"=>"Mac", "version"=>"6.1", "app"=>"/Users/app/path/rufus.app", "use_physical" => true}}
    it 'creates an instance of a regular a non-optimized iOS driver for physical device' do
      Rufus::Drivers::IOS_Device.should_receive(:new).with(iOS_physical_config)
      Rufus::Drivers::DriverFactory.driver_for(iOS_physical_config)
    end
  context 'getting an optimized iOS driver for physical device'
    let(:iOS_physical_optimized){{"browser" =>"iOS", "platform"=>"Mac", "version"=>"6.1", "app"=>"/Users/app/path/rufus.app", "use_physical" => true, "optimized" => true}}
    it 'creates an instance of an optimized iOS driver for a physical device' do
      Rufus::Drivers::IOS_FasterDevice.should_receive(:new).with(iOS_physical_optimized)
      Rufus::Drivers::DriverFactory.driver_for(iOS_physical_optimized)
    end
  end
  context 'getting a regular non-optimized iOS Simulator driver' do
    let(:iOS_simulator_normal){{"browser" =>"iOS", "platform"=>"Mac", "version"=>"6.1", "app"=>"/Users/app/path/rufus.app", "use_physical" => false, "optimized" => false}}
    it 'creates an instance of a regular non-optimized iOS simulator' do
      Rufus::Drivers::IOS_Simulator.should_receive(:new).with(iOS_simulator_normal)
      Rufus::Drivers::DriverFactory.driver_for(iOS_simulator_normal)
    end
  end
  context 'getting an optimized iOS Simulator driver' do
    let(:iOS_simulator_normal){{"browser" =>"iOS", "platform"=>"Mac", "version"=>"6.1", "app"=>"/Users/app/path/rufus.app", "use_physical" => false, "optimized" => true}}
    it 'creates an instance of a regular optimized iOS simulator' do
      Rufus::Drivers::IOS_FasterSimulator.should_receive(:new).with(iOS_simulator_normal)
      Rufus::Drivers::DriverFactory.driver_for(iOS_simulator_normal)
    end
  end
end

