require 'rufus/accessors/table'
require 'spec_helper'

describe Rufus::Accessors::Table do


  context 'getting child elements' do

    let(:table) {Rufus::Accessors::Table.new(:name => 'testTable')}
    let(:selenium){double('Selenium::WebDriver')}
    let(:mock_child_elements){double('list of child elements')}

    before(:each) do
      table.should_receive(:selenium).and_return(selenium)
      selenium.should_receive(:cells).with(:name => 'testTable').and_return(mock_child_elements)
    end

    it 'can get all the child elements of the table' do
      table.children.should eq mock_child_elements
    end

    context 'determining sort' do

      let(:first_element){'first child element'}
      let(:second_element){'second child element'}
      let(:third_element){'third child element'}

      it 'is considered sorted for one child' do
        mock_child_elements.should_receive(:count).and_return 1
        table.sorted?.should be_true
      end

      it 'can tell if the child elements are sorted' do
        mock_child_elements.should_receive(:count).and_return 3
        mock_child_elements.should_receive(:map).and_return(["1","2","3"])
        table.sorted?.should be_true
      end

      it 'does not matter if the list is sorted in reverse' do
        mock_child_elements.should_receive(:count).and_return 3
        mock_child_elements.should_receive(:map).exactly(2).times.and_return(["3","2","1"])
        table.sorted?.should be_true
      end

      it 'says no if there is an element out of order' do
        mock_child_elements.should_receive(:count).and_return 3
        mock_child_elements.should_receive(:map).exactly(2).times.and_return(["3","0","1"])
        table.sorted?.should be_false
      end
    end
  end
end