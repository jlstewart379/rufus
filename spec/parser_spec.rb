require 'spec_helper'
require 'rufus/parser'



describe Rufus::Parser do
  context 'initializing' do
    context 'json is valid' do
      let(:valid){'{\"name\":\"showAlertButton\",\"type\":\"UIAButton\",\"label\":\"showAlertButton\",\"value\":null,\"rect\":{\"origin\":{\"x\":304,\"y\":302},\"size\":{\"width\":150,\"height\":30}},\"dom\":null,\"enabled\":true,\"valid\":true,\"visible\":true,\"children\":[]}'}
      before(:each) do
        @parser = Rufus::Parser.new(valid)
      end
      it 'loads the json' do
        @parser.screen_data.should == {"name"=>"showAlertButton", "type"=>"UIAButton", "label"=>"showAlertButton", "value"=>nil, "rect"=>{"origin"=>{"x"=>304, "y"=>302}, "size"=>{"width"=>150, "height"=>30}}, "dom"=>nil, "enabled"=>true, "valid"=>true, "visible"=>true, "children"=>[]}
      end
    end
    context 'json is invalid' do
      let(:invalid){'This is not json'}
      it 'does not like invalid json' do
       expect{Rufus::Parser.new(invalid).to raise_error(MultiJson::LoadError)}
      end
    end
  end

  context 'getting view data' do

    let(:single_view){'{\"name\":\"showAlertButton\",\"type\":\"UIAButton\",\"label\":\"showAlertButton\",\"value\":\"Hello\",\"rect\":{\"origin\":{\"x\":304,\"y\":302},\"size\":{\"width\":150,\"height\":30}},\"dom\":null,\"enabled\":true,\"valid\":true,\"visible\":true,\"children\":[]}'}
    before(:each) do
      @parser = Rufus::Parser.new(single_view)
    end
    context 'getting the view class' do
        it 'can find the class of a view' do
          @parser.class_for('showAlertButton').should == 'UIAButton'
        end
        it 'says the class is not there if it cannot find it' do
          @parser.class_for('doesNotExist').should be_nil
        end
    end
    context 'getting the views value' do
      it 'can get the value of view' do
        @parser.value('showAlertButton').should == 'Hello'
      end
      it 'is nil if the view label is not found' do
        @parser.value('doesNotExist').should be_nil
      end
    end

    context 'getting view dimensions' do
      it 'can get the views width' do
        @parser.width('showAlertButton').should == 150
      end
      it 'is nil if label not found when getting width' do
        @parser.width('doesNotExist').should be_nil
      end
      it 'can get the views height' do
        @parser.height('showAlertButton').should == 30
      end
      it 'is nil if label not found when getting width' do
        @parser.height('doesNotExist').should be_nil
      end
      it 'can get the views x position' do
        @parser.x_pos('showAlertButton').should == 304
      end
      it 'is nil if label not found when getting x position' do
        @parser.x_pos('doesNotExist').should be_nil
      end
      it 'can get the views y position' do
        @parser.y_pos('showAlertButton').should == 302
      end
      it 'is nil if label not found when getting y position' do
        @parser.y_pos('doesNotExist').should be_nil
      end
    end
  end
end