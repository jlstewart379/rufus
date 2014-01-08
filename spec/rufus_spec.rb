require 'spec_helper'
require 'rufus/driver'
require 'rufus/drivers/iOS_device'
require 'rufus/drivers/iOS_simulator'
require 'yaml'

describe Rufus do
  include Rufus

  let(:mock_wait){'mock Rufus::Waiter'}
  let(:mock_view){'a mock view object'}
  let(:selenium){double('Selenium::WebDriver')}


  context 'waiting for an element to exist' do
    context 'element exists with timeout given' do
      it 'returns true if an element is found before given timeout occurs' do
        Rufus::Waiter.should_receive(:new).with(selenium, :timeout => 1).and_return(mock_wait)
        mock_wait.should_receive(:until).and_return(true)
        exists_after_wait?(mock_view, 1).should be_true
      end
      it 'returns true if an element is found before default timeout occurs' do
        Rufus::Waiter.should_receive(:new).with(selenium, :timeout => 5).and_return(mock_wait)
        mock_wait.should_receive(:until).and_return(true)
        exists_after_wait?(mock_view).should be_true
      end
    end
  end

  context 'waiting for an element to be displayed' do
    context 'element is displayed with timeout given' do
        it 'returns true if an element is displayed before given timeout occurs' do
          Rufus::Waiter.should_receive(:new).with(selenium, :timeout => 1).and_return(mock_wait)
          mock_wait.should_receive(:until).and_return(true)
          displayed_after_wait?(mock_view, 1).should be_true
        end
        it 'returns true if an element is displayed before default timeout occurs' do
          Rufus::Waiter.should_receive(:new).with(selenium, :timeout => 5).and_return(mock_wait)
          mock_wait.should_receive(:until).and_return(true)
          displayed_after_wait?(mock_view).should be_true
        end
      end
    end
  context 'waiting for an element to be enabled' do
    context 'element is enabled with timeout given' do
      it 'returns true if an element is enabled before given timeout occurs' do
        Rufus::Waiter.should_receive(:new).with(selenium, :timeout => 1).and_return(mock_wait)
        mock_wait.should_receive(:until).and_return(true)
        enabled_after_wait?(mock_view, 1).should be_true
      end
      it 'returns true if an element is not enabled before default timeout occurs' do
        Rufus::Waiter.should_receive(:new).with(selenium, :timeout => 5).and_return(mock_wait)
        mock_wait.should_receive(:until).and_return(true)
        enabled_after_wait?(mock_view).should be_true
      end
    end
  end

  context 'elements without accessors' do

    let(:selenium){'mock driver factory'}
    let(:raw_selenium){'raw selenium driver'}
    let(:mock_element){'mock selenium element'}
    let(:elements){'mock list of elements'}

    before(:each) do
      selenium.should_receive(:send).with(:driver).and_return(raw_selenium)
    end

    it 'can find an element by name' do
      raw_selenium.should_receive(:find).with(:name => 'rufusButton').and_return(mock_element)
      mock_element.should_receive(:click)
      click(:name => 'rufusButton')
    end
    it 'can get the raw page data' do
      raw_selenium.should_receive(:page_source).and_return("source data")
      page_source.should eq("source data")
    end
    it 'can get a list of buttons' do
      raw_selenium.should_receive(:elements_by_tag).with('UIAButton')
      elements_of_type 'UIAButton'
    end
    it 'can swipe to the right' do
      raw_selenium.should_receive(:scroll_to).with(:name => 'elementName')
      scroll_to(:name => 'elementName')
    end
  end
  context 'using locators to find elements not defined with accessors' do

    let(:test_locator){{:name => 'someViewName'}}

    context 'determine if element is enabled' do
      before(:each) do
        Rufus::Waiter.should_receive(:new).with(selenium, :timeout => 5).and_return(mock_wait)
        Rufus::Accessors::View.should_receive(:new).with(test_locator).and_return(mock_view)
      end
      it 'can determine if an element is enabled' do
        mock_wait.should_receive(:until).and_return(true)
        enabled_hash_after_wait?(test_locator).should be_true
      end
      it 'can determine if an element is not enabled' do
        mock_wait.should_receive(:until).and_return(false)
        enabled_hash_after_wait?(test_locator).should be_false
      end
    end
    context 'determine if element is displayed' do
      before(:each) do
        Rufus::Waiter.should_receive(:new).with(selenium, :timeout => 5).and_return(mock_wait)
        Rufus::Accessors::View.should_receive(:new).with(test_locator).and_return(mock_view)
      end
      it 'can determine if an element is enabled' do
        mock_wait.should_receive(:until).and_return(true)
        displayed_hash_after_wait?(test_locator).should be_true
      end
      it 'can determine if an element is not enabled' do
        mock_wait.should_receive(:until).and_return(false)
        displayed_hash_after_wait?(test_locator).should be_false
      end
    end
    context 'determine if element exists by hash' do
      before(:each) do
        Rufus::Waiter.should_receive(:new).with(selenium, :timeout => 5).and_return(mock_wait)
        Rufus::Accessors::View.should_receive(:new).with(test_locator).and_return(mock_view)
      end
      it 'can determine if an element is enabled' do
        mock_wait.should_receive(:until).and_return(true)
        exists_hash_after_wait?(test_locator).should be_true
      end
      it 'can determine if an element is not enabled' do
        mock_wait.should_receive(:until).and_return(false)
        exists_hash_after_wait?(test_locator).should be_false
      end
    end
  end
end