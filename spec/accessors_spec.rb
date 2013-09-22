require 'spec_helper'

class TestPage
  include Rufus

  view(:some_view, :name => 'testView')
  label(:some_label, :name => 'someLabel')
  text(:some_text_box, :name => 'someTextBox')
  button(:some_button, :name => 'someButton')

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

    it 'can click a view' do
      view.should_receive(:click)
      screen.some_view
    end
  end

  context 'label' do
    let(:label) { double('Label accessor') }

    before(:each) do
      Rufus::Accessors::View.should_receive(:new).with(:name => 'someLabel').and_return(label)
    end

    it 'can return the label' do
      screen.some_label_view.should be(label)
    end

    it 'can click a label' do
      label.should_receive(:click)
      screen.some_label
    end
  end

  context 'text box' do
    let(:text_box) { double('Label accessor') }

    before(:each) do
      Rufus::Accessors::View.should_receive(:new).with(:name => 'someTextBox').and_return(text_box)
    end

    it 'can return the text box' do
      screen.some_text_box_view.should be(text_box)
    end

    it 'can click a text box' do
      text_box.should_receive(:click)
      screen.some_text_box
    end
  end

  context 'button' do
    let(:button) { double('Label accessor') }

    before(:each) do
      Rufus::Accessors::View.should_receive(:new).with(:name => 'someButton').and_return(button)
    end

    it 'can return the button' do
      screen.some_button_view.should be(button)
    end

    it 'can click a button' do
      button.should_receive(:click)
      screen.some_button
    end
  end
end

