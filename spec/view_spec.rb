require 'rufus/accessors/view'
require 'spec_helper'


describe Rufus::Accessors::View do

  let(:view){ view = View.new('testView')}

  context 'locating views' do

    it 'can locate a view by label' do
      view = Rufus::Accessors::View.new(:name => 'textView')
      view.send(:find).should eq('find_elements(:name, "textView")')
    end

  end
end
