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
    end

    context 'selecting elements' do

      let(:mock_element){'some element'}

      it 'can select a table item by index' do
        mock_child_elements.should_receive(:[]).with(1).and_return(mock_element)
        mock_child_elements.should_receive(:count).and_return(1)
        mock_element.should_receive(:click)
        table.click_on 2
      end

      it 'can select a table item by label' do
        mock_child_elements.should_receive(:each)
        table.click_on 'labelName'
      end
    end
  end
end