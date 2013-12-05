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
        puts @parser.screen_data
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

    let(:single_view){'{\"name\":\"showAlertButton\",\"type\":\"UIAButton\",\"label\":\"showAlertButton\",\"value\":null,\"rect\":{\"origin\":{\"x\":304,\"y\":302},\"size\":{\"width\":150,\"height\":30}},\"dom\":null,\"enabled\":true,\"valid\":true,\"visible\":true,\"children\":[]}'}

    context 'it can get a view class' do



    end

  end

end