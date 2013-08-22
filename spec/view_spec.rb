require 'rufus/accessors/view'
require 'spec_helper'


describe Rufus::Accessors::View do
  context 'locating views' do

    it 'can locate a view by label' do
      view = Rufus::Accessors::View.new(:name => 'textView')
      view.send(:args).should eq([:name, 'textView'])
    end

  end

  context 'checking for existence' do

    let(:view){Rufus::Accessors::View.new(:name => 'testView')}

    context 'element exists' do
      it 'reports that element exists' do
        view.should_receive(:find_elements).and_return(Selenium::WebDriver::Element.new(nil, nil))
        view.exists?.should be_true
      end
    end

    context 'element does not exist' do
      it 'reports that the element does not exist' do
        view.should_receive(:find_elements).and_return(nil)
        view.exists?.should be_false
      end

    end
  end
end
