require 'spec_helper'
require 'rufus/waiter'

describe Rufus::Waiter do

  let(:view){'mock view'}
  let(:driver){'mock selenium driver'}

  before(:each) do
    @waiter = Rufus::Waiter.new driver, :timeout => 0.1, :interval => 0.1
    driver.should_receive(:reset_page_source)
  end

  it 'returns false if the block is not true' do
    view.should_receive(:exists?).and_return(false)
    @waiter.wait_until{view.exists?}.should be_false
  end

  it 'returns true if the block is true' do
    view.should_receive(:exists?).and_return(true)
    @waiter.wait_until{view.exists?}.should be_true
  end
end