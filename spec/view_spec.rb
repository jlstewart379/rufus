require 'rufus/accessors/view'
require 'spec_helper'


describe Rufus::Accessors::View do
  context 'checking for existence' do

    let(:view){Rufus::Accessors::View.new(:label => 'testView')}
    let(:view_by_text){Rufus::Accessors::View.new(:text => "textViewText")}
    let(:selenium){double('Selenium::WebDriver')}

    before(:each) do
      view.should_receive(:selenium).and_return(selenium)
    end

    context 'element exists' do
      it 'reports that element exists' do
        selenium.should_receive(:find_elements).and_return(Selenium::WebDriver::Element.new(nil, nil))
        view.exists?.should be_true
      end
    end

    context 'element does not exist' do
      it 'reports that the element does not exist' do
        selenium.should_receive(:find_elements).and_return(nil)
        view.exists?.should be_false
      end
    end

    context 'clicking an element' do
      let(:element){double('Selenium element')}

      it 'can click an element' do
        selenium.should_receive(:find_elements).with(:name, 'testView').and_return(element)
        element.should_receive(:click)
        view.click
      end
    end

    context 'locaging elements by text' do
      it 'can locate an element using text locator' do

      end
    end

  end
end







