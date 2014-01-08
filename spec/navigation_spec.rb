require 'spec_helper'
require 'rufus/navigation'
include Rufus::Navigation

class RufusNavPage

end

describe Rufus::Navigation do

  let(:mock_page){'mock page object'}
  let(:mock_block){lambda{}}

  context 'getting the active screen' do

    let(:selenium){double('mock selenium driver')}

    before (:each) do
      selenium.should_receive(:reset_page_source)
      mock_page.should_receive(:new).and_return(mock_page)
    end

    it 'raises exception if screen does not become active' do
      mock_page.should_receive(:active?).at_least(1).times.and_return false
      expect{on(mock_page, 1)}.to raise_error
    end

    it 'returns the active screen' do
      mock_page.should_receive(:active?).and_return true
      on(mock_page).should eq mock_page
    end

    it 'can execute a block' do
      mock_page.should_receive(:active?).and_return true
      mock_block.should_receive(:call).with mock_page
      on(mock_page, &mock_block)
    end

  end









end