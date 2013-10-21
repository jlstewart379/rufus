require 'rufus/accessors/table'
require 'spec_helper'

describe Rufus::Accessors::Table do


  context 'getting child elements' do

    let(:table) {Rufus::Accessors::Table.new(:name => 'testTable')}
    let(:selenium){double('Selenium::WebDriver')}
    let(:mock_child_elements){'list of child elements'}

    before(:each) do
      table.should_receive(:selenium).and_return(selenium)
      selenium.should_receive(:children).with(:name => 'testTable').and_return(mock_child_elements)
    end

    it 'can get all the child elements of the table' do

      table.children.should eq mock_child_elements


    end



  end



end