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

      it 'can get the label of the view' do
        @parser.label_for('showAlertButton').should eq('showAlertButton')
      end
    end

    context 'getting view state' do
      it 'can tell if the view is enabled' do
        @parser.enabled?('showAlertButton').should be_true
      end
      it 'can tell if the view is visible' do
        @parser.displayed?('showAlertButton').should be_true
      end
    end
  end

  context 'getting nested views' do
    let(:view_data){'{\"name\":\"showAlertButton\",\"type\":\"UIAButton\",\"label\":\"showAlertButton\",\"value\":\"Hello\",\"rect\":{\"origin\":{\"x\":304,\"y\":302},\"size\":{\"width\":150,\"height\":30}},\"dom\":null,\"enabled\":true,\"valid\":true,\"visible\":true,\"children\":[{"name":"firstChild","type":"UIAImage","label":null,"value":null,"rect":{"origin":{"x":0,"y":1023},"size":{"width":768,"height":1}},"dom":null,"enabled":true,"valid":true,"visible":false,"children":[{"name":"firstNested","type":"UIStaticText","label":null,"value":null,"rect":{"origin":{"x":0,"y":1024},"size":{"width":668,"height":44}},"dom":null,"enabled":true,"valid":true,"visible":false,"children":[]}]},{"name":"secondChild","type":"UIAButton","label":null,"value":null,"rect":{"origin":{"x":0,"y":1024},"size":{"width":568,"height":34}},"dom":null,"enabled":false,"valid":true,"visible":true,"children":[{"name":"childOfSecondChild","type":"UIATableViewCell","label":null,"value":null,"rect":{"origin":{"x":0,"y":1024},"size":{"width":468,"height":24}},"dom":null,"enabled":true,"valid":true,"visible":false,"children":[]}]}]}'}
    before(:each) do
      @parser = Rufus::Parser.new(view_data)
    end
    it 'can get the root view' do
      @parser.view_by_label('showAlertButton').should == {"name"=>"showAlertButton", "type"=>"UIAButton", "label"=>"showAlertButton", "value"=>"Hello", "rect"=>{"origin"=>{"x"=>304, "y"=>302}, "size"=>{"width"=>150, "height"=>30}}, "dom"=>nil, "enabled"=>true, "valid"=>true, "visible"=>true, "children"=>[{"name"=>"firstChild", "type"=>"UIAImage", "label"=>nil, "value"=>nil, "rect"=>{"origin"=>{"x"=>0, "y"=>1023}, "size"=>{"width"=>768, "height"=>1}}, "dom"=>nil, "enabled"=>true, "valid"=>true, "visible"=>false, "children"=>[{"name"=>"firstNested", "type"=>"UIStaticText", "label"=>nil, "value"=>nil, "rect"=>{"origin"=>{"x"=>0, "y"=>1024}, "size"=>{"width"=>668, "height"=>44}}, "dom"=>nil, "enabled"=>true, "valid"=>true, "visible"=>false, "children"=>[]}]}, {"name"=>"secondChild", "type"=>"UIAButton", "label"=>nil, "value"=>nil, "rect"=>{"origin"=>{"x"=>0, "y"=>1024}, "size"=>{"width"=>568, "height"=>34}}, "dom"=>nil, "enabled"=>false, "valid"=>true, "visible"=>true, "children"=>[{"name"=>"childOfSecondChild", "type"=>"UIATableViewCell", "label"=>nil, "value"=>nil, "rect"=>{"origin"=>{"x"=>0, "y"=>1024}, "size"=>{"width"=>468, "height"=>24}}, "dom"=>nil, "enabled"=>true, "valid"=>true, "visible"=>false, "children"=>[]}]}]}
    end
    it 'can get the first child of the root view' do
      @parser.view_by_label('firstChild').should == {"name"=>"firstChild", "type"=>"UIAImage", "label"=>nil, "value"=>nil, "rect"=>{"origin"=>{"x"=>0, "y"=>1023}, "size"=>{"width"=>768, "height"=>1}}, "dom"=>nil, "enabled"=>true, "valid"=>true, "visible"=>false, "children"=>[{"name"=>"firstNested", "type"=>"UIStaticText", "label"=>nil, "value"=>nil, "rect"=>{"origin"=>{"x"=>0, "y"=>1024}, "size"=>{"width"=>668, "height"=>44}}, "dom"=>nil, "enabled"=>true, "valid"=>true, "visible"=>false, "children"=>[]}]}
    end
    it 'can get the second child of the root view' do
      @parser.view_by_label('secondChild').should == {"name"=>"secondChild", "type"=>"UIAButton", "label"=>nil, "value"=>nil, "rect"=>{"origin"=>{"x"=>0, "y"=>1024}, "size"=>{"width"=>568, "height"=>34}}, "dom"=>nil, "enabled"=>false, "valid"=>true, "visible"=>true, "children"=>[{"name"=>"childOfSecondChild", "type"=>"UIATableViewCell", "label"=>nil, "value"=>nil, "rect"=>{"origin"=>{"x"=>0, "y"=>1024}, "size"=>{"width"=>468, "height"=>24}}, "dom"=>nil, "enabled"=>true, "valid"=>true, "visible"=>false, "children"=>[]}]}
    end
    it 'can get a child of the root views first child' do
      @parser.view_by_label('childOfSecondChild').should == {"name"=>"childOfSecondChild", "type"=>"UIATableViewCell", "label"=>nil, "value"=>nil, "rect"=>{"origin"=>{"x"=>0, "y"=>1024}, "size"=>{"width"=>468, "height"=>24}}, "dom"=>nil, "enabled"=>true, "valid"=>true, "visible"=>false, "children"=>[]}
    end
  end
end