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
        element.should_receive(:attribute).with(:name).and_return('Alert Title')
        alert.title.should eq('Alert Title')
      end

    end

    #context 'clicking an element' do
    #  it 'can click an element' do
    #    selenium.should_receive(:find).with({:label =>'testView'}).and_return(element)
    #    element.should_receive(:click)
    #    alert.click
    #  end
    #end
    #
    #context 'telling if a view is displayed' do
    #  it 'can tell if a view is displayed' do
    #    selenium.should_receive(:find).with({:label =>'testView'}).and_return(element)
    #    element.should_receive(:displayed?).and_return(true)
    #    view.displayed?.should be_true
    #  end
    #  it 'can tell if a view is not displayed' do
    #    selenium.should_receive(:find).with({:label =>'testView'}).and_return(element)
    #    element.should_receive(:displayed?).and_return(false)
    #    view.displayed?.should be_false
    #  end
    #end
    #
    #context 'telling if a view is enabled' do
    #  it 'can tell if a view is enabled' do
    #    selenium.should_receive(:find).with({:label =>'testView'}).and_return(element)
    #    element.should_receive(:enabled?).and_return(true)
    #    view.enabled?.should be_true
    #  end
    #  it 'can tell if a view is not enabled' do
    #    selenium.should_receive(:find).with({:label =>'testView'}).and_return(element)
    #    element.should_receive(:enabled?).and_return(false)
    #    view.enabled?.should be_false
    #  end
    #end
    #
    #context 'getting text from a view' do
    #  it 'can get the text of a view' do
    #    selenium.should_receive(:find).with({:label =>'testView'}).and_return(element)
    #    element.should_receive(:text).and_return("some text")
    #    view.text.should eq("some text")
    #  end
    #end
    #
    #context 'sending text input to a view' do
    #  it 'can send text input to a view' do
    #    selenium.should_receive(:find).with({:label =>'testView'}).and_return(element)
    #    element.should_receive(:send_keys).with("keyboard entries")
    #    view.send_keys("keyboard entries")
    #  end
    #end
    #
    #context 'getting the class of a view' do
    #  it 'can get the UIAutomation class respresntation of view' do
    #    element.should_receive(:tag_name).and_return('UIStaticText')
    #    selenium.should_receive(:find).with({:label =>'testView'}).and_return(element)
    #    view.class.should eql('UIStaticText')
    #  end
    #end

  end

  #context 'finding element by text' do
  #
  #  let(:view_by_text){Rufus::Accessors::View.new(:text => "textViewText")}
  #  let(:selenium){double('Selenium::WebDriver')}
  #  let(:element){double('Selenium element')}
  #
  #  it 'tells selenium to search by text' do
  #    view_by_text.should_receive(:selenium).and_return(selenium)
  #    selenium.should_receive(:find).with({:text=>'textViewText'}).and_return(element)
  #    view_by_text.exists?
  #  end
  #end
end