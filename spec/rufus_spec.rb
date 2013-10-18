require 'spec_helper'
require 'rufus/driver'
require 'rufus/drivers/iOS_device'
require 'rufus/drivers/iOS_simulator'
require 'yaml'

describe Rufus do
  include Rufus

  context 'waiting for an element to exist' do

    let(:mock_wait){'mock Selenium::WebDriver::Wait'}
    let(:mock_view){'a mock view object'}

    context 'element exists with timeout given' do
      it 'returns true if an element is found before given timeout occurs' do
        Selenium::WebDriver::Wait.should_receive(:new).with(:timeout => 20).and_return(mock_wait)
        mock_wait.should_receive(:until)
        exists_after_wait?(mock_view, 20).should be_true
      end
      it 'returns true if an element is found before default timeout occurs' do
        Selenium::WebDriver::Wait.should_receive(:new).with(:timeout => 5).and_return(mock_wait)
        mock_wait.should_receive(:until)
        exists_after_wait?(mock_view).should be_true
      end
    end
    context 'element does not exist' do
      it 'returns false if the timeout is reached' do
        Selenium::WebDriver::Wait.should_receive(:new).with(:timeout => 5).and_return(mock_wait)
        mock_wait.should_receive(:until).and_raise(Selenium::WebDriver::Error::TimeOutError)
        exists_after_wait?(mock_view).should be_false
      end
    end
  end

  context 'waiting for an element to be displayed' do

    let(:mock_wait){'mock Selenium::WebDriver::Wait'}
    let(:mock_view){'a mock view object'}

    context 'element is displayed with timeout given' do
      it 'returns true if an element is displayed before given timeout occurs' do
        Selenium::WebDriver::Wait.should_receive(:new).with(:timeout => 20).and_return(mock_wait)
        mock_wait.should_receive(:until)
        displayed_after_wait?(mock_view, 20).should be_true
      end
      it 'returns true if an element is displayed before default timeout occurs' do
        Selenium::WebDriver::Wait.should_receive(:new).with(:timeout => 5).and_return(mock_wait)
        mock_wait.should_receive(:until)
        displayed_after_wait?(mock_view).should be_true
      end
    end
    context 'element does not exist' do
      it 'returns false if the timeout is reached' do
        Selenium::WebDriver::Wait.should_receive(:new).with(:timeout => 5).and_return(mock_wait)
        mock_wait.should_receive(:until).and_raise(Selenium::WebDriver::Error::TimeOutError)
        displayed_after_wait?(mock_view).should be_false
      end
    end
  end
  context 'waiting for an element to be enabled' do

    let(:mock_wait){'mock Selenium::WebDriver::Wait'}
    let(:mock_view){'a mock view object'}

    context 'element is enabled with timeout given' do
      it 'returns true if an element is displayed before given timeout occurs' do
        Selenium::WebDriver::Wait.should_receive(:new).with(:timeout => 20).and_return(mock_wait)
        mock_wait.should_receive(:until)
        enabled_after_wait?(mock_view, 20).should be_true
      end
      it 'returns true if an element is enabled before default timeout occurs' do
        Selenium::WebDriver::Wait.should_receive(:new).with(:timeout => 5).and_return(mock_wait)
        mock_wait.should_receive(:until)
        enabled_after_wait?(mock_view).should be_true
      end
    end
    context 'element does not exist' do
      it 'returns false if the timeout is reached' do
        Selenium::WebDriver::Wait.should_receive(:new).with(:timeout => 5).and_return(mock_wait)
        mock_wait.should_receive(:until).and_raise(Selenium::WebDriver::Error::TimeOutError)
        enabled_after_wait?(mock_view).should be_false
      end
    end
  end

  context 'elements without accessors' do

    let(:selenium){'mock selenium driver'}
    let(:mock_element){'mock selenium element'}

    it 'can find an element by name' do
      selenium.should_receive(:find).with({:name => 'rufusButton'}).and_return(mock_element)
      mock_element.should_receive(:click)
      click(:name => 'rufusButton')
    end
  end

  context 'getting the raw page data' do

    let(:selenium){'mock selenium driver'}
    let(:elements){'mock list of elements'}

    it 'can get the raw page data' do
      selenium.should_receive(:page_source).and_return("source data")
      page_source.should eq("source data")
    end

    it 'can get a list of buttons' do
      selenium.should_receive(:elements_by_tag).with('UIAButton').and_return(elements)
      elements_of_type 'UIAButton'
    end

  end

  context 'swiping' do
    let(:selenium){'mock selenium driver'}
    it 'can swipe to the right' do
      selenium.should_receive(:swipe).with(:name => 'elementName')
      swipe_right(:name => 'elementName')
    end
  end
end