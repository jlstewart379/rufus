require 'rufus/accessors/label'
require 'spec_helper'


describe Rufus::Accessors::Label do

  context 'checking for existence' do
    let(:label){Rufus::Accessors::Label.new(:label => 'testView')}
    let(:view_by_text){Rufus::Accessors::View.new(:text => "textViewText")}
    let(:selenium){double('Selenium::WebDriver')}
    let(:element){double('Selenium element')}

    before(:each) do
      label.should_receive(:selenium).and_return(selenium)
    end

    context 'element exists' do
      it 'reports that element exists' do
        selenium.should_receive(:find).and_return(Selenium::WebDriver::Element.new(nil, nil))
        label.exists?.should be_true
      end
    end

    context 'element does not exist' do
      it 'reports that the element does not exist' do
        selenium.should_receive(:find).and_return(nil)
        label.exists?.should be_false
      end
    end

    context 'clicking an element' do
      it 'can click an element' do
        selenium.should_receive(:find).with('testView').and_return(element)
        element.should_receive(:click)
        label.click
      end
    end

    context 'telling if a view is displayed' do
      it 'can tell if a view is displayed' do
        selenium.should_receive(:find).with('testView').and_return(element)
        element.should_receive(:displayed?).and_return(true)
        label.displayed?.should be_true
      end
      it 'can tell if a view is not displayed' do
        selenium.should_receive(:find).with('testView').and_return(element)
        element.should_receive(:displayed?).and_return(false)
        label.displayed?.should be_false
      end
    end

    context 'telling if a view is enabled' do
      it 'can tell if a view is enabled' do
        selenium.should_receive(:find).with('testView').and_return(element)
        element.should_receive(:enabled?).and_return(true)
        label.enabled?.should be_true
      end
      it 'can tell if a view is not enabled' do
        selenium.should_receive(:find).with('testView').and_return(element)
        element.should_receive(:enabled?).and_return(false)
        label.enabled?.should be_false
      end
    end

    context 'getting text from a view' do
      it 'can get the text of a view' do
        selenium.should_receive(:find).with('testView').and_return(element)
        element.should_receive(:text).and_return("some text")
        label.text.should eq("some text")
      end
    end

    context 'sending text input to a view' do
      it 'can send text input to a view' do
        selenium.should_receive(:find).with('testView').and_return(element)
        element.should_receive(:send_keys).with("keyboard entries")
        label.send_keys("keyboard entries")
      end
    end

    context 'finding a view by text' do
      it 'can find a view by text' do
        selenium.should_receive(:find_by_text).with('textViewText')
        label.

      end
    end

  end
end







