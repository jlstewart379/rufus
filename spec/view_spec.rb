require 'rufus/accessors/view'
require 'spec_helper'


describe Rufus::Accessors::View do

  context 'checking for existence' do
    let(:view){Rufus::Accessors::View.new(:name => 'testView')}
    let(:view_by_text){Rufus::Accessors::View.new(:text => "textViewText")}
    let(:selenium){double('Selenium::WebDriver')}
    let(:element){double('Selenium element')}

    before(:each) do
      view.should_receive(:selenium).and_return(selenium)
    end

    context 'element exists' do
      it 'reports that element exists' do
        selenium.should_receive(:exists?).with(:name => 'testView').and_return(true)
        view.exists?.should be_true
      end
    end

    context 'element does not exist' do
      it 'reports that the element does not exist' do
        selenium.should_receive(:exists?).with(:name => 'testView').and_return(false)
        view.exists?.should be_false
      end
    end

    context 'clicking an element' do
      it 'can click an element' do
        selenium.should_receive(:click).with({:name =>'testView'})
        view.click
      end
    end

    context 'telling if a view is displayed' do
      it 'can tell if a view is displayed' do
        selenium.should_receive(:displayed?).with({:name =>'testView'}).and_return(true)
        view.displayed?.should be_true
      end
      it 'can tell if a view is not displayed' do
        selenium.should_receive(:displayed?).with({:name =>'testView'}).and_return(false)
        view.displayed?.should be_false
      end
    end

    context 'telling if a view is enabled' do
      it 'can tell if a view is enabled' do
        selenium.should_receive(:enabled?).with({:name =>'testView'}).and_return(true)
        view.enabled?.should be_true
      end
      it 'can tell if a view is not enabled' do
        selenium.should_receive(:enabled?).with({:name =>'testView'}).and_return(false)
        view.enabled?.should be_false
      end
    end

    context 'getting text from a view' do
      it 'can get the text of a view' do
        selenium.should_receive(:text).with({:name =>'testView'}).and_return('some text')
        view.text.should eq("some text")
      end
    end

    context 'sending text input to a view' do
      it 'can send text input to a view' do
        selenium.should_receive(:type).with('keyboard entries', 'testView').and_return(element)
        view.send_keys("keyboard entries")
      end
    end

    context 'getting the class of a view' do
      it 'can get the UIAutomation class representation of view' do
        selenium.should_receive(:class).with({:name =>'testView'}).and_return('UIAStaticText')
        view.class.should eql('UIAStaticText')
      end
    end

  end

  context 'finding element by text' do

    let(:view_by_text){Rufus::Accessors::View.new(:text => "textViewText")}
    let(:selenium){double('Selenium::WebDriver')}
    let(:element){double('Selenium element')}

    it 'tells selenium to search by text' do
      view_by_text.should_receive(:selenium).and_return(selenium)
      selenium.should_receive(:exists?).with({:text=>'textViewText'}).and_return(element)
      view_by_text.exists?
    end
  end
end







