require 'rufus/accessors/alert'
require 'spec_helper'


describe Rufus::Accessors::Alert do

  context 'checking for existence' do
    let(:alert){Rufus::Accessors::Alert.new(:label => 'testView')}
    let(:alert_by_text){Rufus::Accessors::Alert.new(:text => "textViewText")}
    let(:selenium){double('Selenium::WebDriver')}
    let(:element){double('Selenium element')}

    before(:each) do
      alert.should_receive(:selenium).and_return(selenium)
    end

    context 'element exists' do
      it 'reports that element exists' do
        selenium.should_receive(:find).and_return(Selenium::WebDriver::Element.new(nil, nil))
        alert.exists?.should be_true
      end
    end

    context 'element does not exist' do
      it 'reports that the element does not exist' do
        selenium.should_receive(:find).and_return(nil)
        alert.exists?.should be_false
      end
    end

    context 'getting the alert view title' do

      it 'can get the title of the alert view' do
        selenium.should_receive(:find_alert).and_return(element)
        element.should_receive(:attribute).with('name').and_return('Alert Title')
        alert.title.should eq('Alert Title')
      end

    end
  end
end