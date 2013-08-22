require 'spec_helper'

class TestPage
  include Rufus

  view(:some_view, :name => 'testView')

end

describe Rufus::Accessors do

  let(:screen) { TestPage.new }

  context 'view' do
    let(:view) { double('View accessor') }

    before(:each) do
      Rufus::Accessors::View.should_receive(:new).with(:name => 'testView').and_return(view)
    end

    it 'can return the view object' do
      screen.some_view_view.should be(view)
    end
  end
end

