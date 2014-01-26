require 'spec_helper'
require 'rufus/parser'

describe Rufus::Parser do
  context 'initializing' do
    context 'json is valid' do
      valid = "{\"name\":\"showAlertButton\",\"type\":\"UIAButton\",\"label\":\"showAlertButton\",\"value\":null,\"rect\":{\"origin\":{\"x\":304,\"y\":302},\"size\":{\"width\":150,\"height\":30}},\"dom\":null,\"enabled\":true,\"valid\":true,\"visible\":true,\"children\":[]}"
      before(:each) do
        @parser = Rufus::Parser.new(valid)
      end
      it 'loads the json' do
        @parser.screen_data.should == {"name"=>"showAlertButton", "type"=>"UIAButton", "label"=>"showAlertButton", "value"=>nil, "rect"=>{"origin"=>{"x"=>304, "y"=>302}, "size"=>{"width"=>150, "height"=>30}}, "dom"=>nil, "enabled"=>true, "valid"=>true, "visible"=>true, "children"=>[]}
      end
    end
    context 'json is invalid' do
      invalid = "{some random}"
      it 'does not like invalid json' do
       expect{Rufus::Parser.new(invalid).to raise_error(JSON::ParserError)}
      end
    end
  end
  context 'getting view data by name' do

    single_view = "{\"name\":\"showAlertButton\",\"type\":\"UIAButton\",\"label\":\"showAlertButton\",\"value\":\"Hello\",\"rect\":{\"origin\":{\"x\":304,\"y\":302},\"size\":{\"width\":150,\"height\":30}},\"dom\":null,\"enabled\":true,\"valid\":true,\"visible\":true,\"children\":[]}"
    before(:each) do
      @parser = Rufus::Parser.new(single_view)
    end
    context 'getting the view class' do
        it 'can find the class of a view' do
          @parser.class_for(:name => 'showAlertButton').should == 'UIAButton'
        end
        it 'says the class is not there if it cannot find it' do
          @parser.class_for(:name => 'doesNotExist').should be_nil
        end
    end
    context 'getting the views value' do
      it 'can get the value of view' do
        @parser.value(:name => 'showAlertButton').should == 'Hello'
      end
      it 'is nil if the view label is not found' do
        @parser.value(:name => 'doesNotExist').should be_nil
      end
    end

    context 'getting view dimensions' do
      it 'can get the views width' do
        @parser.width(:name => 'showAlertButton').should == 150
      end
      it 'is nil if label not found when getting width' do
        @parser.width(:name => 'doesNotExist').should be_nil
      end
      it 'can get the views height' do
        @parser.height(:name => 'showAlertButton').should == 30
      end
      it 'is nil if label not found when getting width' do
        @parser.height(:name => 'doesNotExist').should be_nil
      end
      it 'can get the views x position' do
        @parser.x_pos(:name => 'showAlertButton').should == 304
      end
      it 'is nil if label not found when getting x position' do
        @parser.x_pos(:name => 'doesNotExist').should be_nil
      end
      it 'can get the views y position' do
        @parser.y_pos(:name => 'showAlertButton').should == 302
      end
      it 'is nil if label not found when getting y position' do
        @parser.y_pos(:name => 'doesNotExist').should be_nil
      end

      it 'can get the label of the view' do
        @parser.label_for(:name => 'showAlertButton').should eq('showAlertButton')
      end
    end
    context 'getting view state' do
      it 'can tell if the view is enabled' do
        @parser.enabled?(:name => 'showAlertButton').should be_true
      end
      it 'can tell if the view is visible' do
        @parser.displayed?(:name => 'showAlertButton').should be_true
      end
      context 'view does not exist in hierarchy data' do
        it 'return false when checking enabled state' do
          @parser.enabled?(:name => 'unknownView').should be_false
        end
        it 'returns false when checking displayed state' do
          @parser.displayed?(:name => 'unknownView').should be_false
        end
      end
    end
  end
  context 'getting nested views' do
    view_data = "{\"name\":\"showAlertButton\",\"type\":\"UIAButton\",\"label\":\"showAlertButton\",\"value\":null,\"rect\":{\"origin\":{\"x\":304,\"y\":302},\"size\":{\"width\":150,\"height\":30}},\"dom\":null,\"enabled\":true,\"valid\":true,\"visible\":true,\"children\":[{\"name\":\"firstChild\",\"type\":\"UIAImage\",\"label\":\"showAlertButton\",\"value\":null,\"rect\":{\"origin\":{\"x\":0,\"y\":1023},\"size\":{\"width\":768,\"height\":1}},\"dom\":null,\"enabled\":true,\"valid\":true,\"visible\":true,\"children\":[{\"name\":\"firstNested\",\"type\":\"UIAStaticText\",\"label\":\"showAlertButton\",\"value\":null,\"rect\":{\"origin\":{\"x\":0,\"y\":1024},\"size\":{\"width\":668,\"height\":44}},\"dom\":null,\"enabled\":true,\"valid\":true,\"visible\":true,\"children\":[]}]},{\"name\":\"secondChild\",\"type\":\"UIAButton\",\"label\":\"showAlertButton\",\"value\":null,\"rect\":{\"origin\":{\"x\":0,\"y\":1024},\"size\":{\"width\":568,\"height\":34}},\"dom\":null,\"enabled\":true,\"valid\":true,\"visible\":true,\"children\":[{\"name\":\"childOfSecondChild\",\"type\":\"UIATableViewCell\",\"label\":\"showAlertButton\",\"value\":null,\"rect\":{\"origin\":{\"x\":0,\"y\":1024},\"size\":{\"width\":468,\"height\":24}},\"dom\":null,\"enabled\":true,\"valid\":true,\"visible\":true,\"children\":[]}]}]}"
    before(:each) do
      @parser = Rufus::Parser.new(view_data)
    end
    it 'can get the root view' do
      @parser.view_by_label(:name => 'showAlertButton').should == {"name"=>"showAlertButton", "type"=>"UIAButton", "label"=>"showAlertButton", "value"=>nil, "rect"=>{"origin"=>{"x"=>304, "y"=>302}, "size"=>{"width"=>150, "height"=>30}}, "dom"=>nil, "enabled"=>true, "valid"=>true, "visible"=>true, "children"=>[{"name"=>"firstChild", "type"=>"UIAImage", "label"=>"showAlertButton", "value"=>nil, "rect"=>{"origin"=>{"x"=>0, "y"=>1023}, "size"=>{"width"=>768, "height"=>1}}, "dom"=>nil, "enabled"=>true, "valid"=>true, "visible"=>true, "children"=>[{"name"=>"firstNested", "type"=>"UIAStaticText", "label"=>"showAlertButton", "value"=>nil, "rect"=>{"origin"=>{"x"=>0, "y"=>1024}, "size"=>{"width"=>668, "height"=>44}}, "dom"=>nil, "enabled"=>true, "valid"=>true, "visible"=>true, "children"=>[]}]}, {"name"=>"secondChild", "type"=>"UIAButton", "label"=>"showAlertButton", "value"=>nil, "rect"=>{"origin"=>{"x"=>0, "y"=>1024}, "size"=>{"width"=>568, "height"=>34}}, "dom"=>nil, "enabled"=>true, "valid"=>true, "visible"=>true, "children"=>[{"name"=>"childOfSecondChild", "type"=>"UIATableViewCell", "label"=>"showAlertButton", "value"=>nil, "rect"=>{"origin"=>{"x"=>0, "y"=>1024}, "size"=>{"width"=>468, "height"=>24}}, "dom"=>nil, "enabled"=>true, "valid"=>true, "visible"=>true, "children"=>[]}]}]}
    end
    it 'can get the first child of the root view' do
      @parser.view_by_label(:name => 'firstChild').should == {"name"=>"firstChild", "type"=>"UIAImage", "label"=>"showAlertButton", "value"=>nil, "rect"=>{"origin"=>{"x"=>0, "y"=>1023}, "size"=>{"width"=>768, "height"=>1}}, "dom"=>nil, "enabled"=>true, "valid"=>true, "visible"=>true, "children"=>[{"name"=>"firstNested", "type"=>"UIAStaticText", "label"=>"showAlertButton", "value"=>nil, "rect"=>{"origin"=>{"x"=>0, "y"=>1024}, "size"=>{"width"=>668, "height"=>44}}, "dom"=>nil, "enabled"=>true, "valid"=>true, "visible"=>true, "children"=>[]}]}
    end
    it 'can get the second child of the root view' do
      @parser.view_by_label(:name => 'secondChild').should == {"name"=>"secondChild", "type"=>"UIAButton", "label"=>"showAlertButton", "value"=>nil, "rect"=>{"origin"=>{"x"=>0, "y"=>1024}, "size"=>{"width"=>568, "height"=>34}}, "dom"=>nil, "enabled"=>true, "valid"=>true, "visible"=>true, "children"=>[{"name"=>"childOfSecondChild", "type"=>"UIATableViewCell", "label"=>"showAlertButton", "value"=>nil, "rect"=>{"origin"=>{"x"=>0, "y"=>1024}, "size"=>{"width"=>468, "height"=>24}}, "dom"=>nil, "enabled"=>true, "valid"=>true, "visible"=>true, "children"=>[]}]}
    end

    it 'can get a child of the root views first child' do
      @parser.view_by_label(:name => 'childOfSecondChild').should == {"name"=>"childOfSecondChild", "type"=>"UIATableViewCell", "label"=>"showAlertButton", "value"=>nil, "rect"=>{"origin"=>{"x"=>0, "y"=>1024}, "size"=>{"width"=>468, "height"=>24}}, "dom"=>nil, "enabled"=>true, "valid"=>true, "visible"=>true, "children"=>[]}
    end
  end

  #Tests for find views by label

  context 'getting view data by label' do

    single_view = "{\"name\":\"showAlertButton\",\"type\":\"UIAButton\",\"label\":\"showAlertLabel\",\"value\":\"Hello\",\"rect\":{\"origin\":{\"x\":304,\"y\":302},\"size\":{\"width\":150,\"height\":30}},\"dom\":null,\"enabled\":true,\"valid\":true,\"visible\":true,\"children\":[]}"
    before(:each) do
      @parser = Rufus::Parser.new(single_view)
    end
    context 'getting the view class' do
      it 'can find the class of a view' do
        @parser.class_for(:label => 'showAlertLabel').should == 'UIAButton'
      end
      #it 'says the class is not there if it cannot find it' do
      #  @parser.class_for(:label => 'doesNotExist').should be_nil
      #end
    end
    context 'getting the views value' do
      it 'can get the value of view' do
        @parser.value(:name => 'showAlertButton').should == 'Hello'
      end
      it 'is nil if the view label is not found' do
        @parser.value(:name => 'doesNotExist').should be_nil
      end
    end

    context 'getting view dimensions' do
      it 'can get the views width' do
        @parser.width(:label => 'showAlertLabel').should == 150
      end
      it 'is nil if label not found when getting width' do
        @parser.width(:label => 'doesNotExist').should be_nil
      end
      it 'can get the views height' do
        @parser.height(:label => 'showAlertLabel').should == 30
      end
      it 'is nil if label not found when getting width' do
        @parser.height(:label => 'doesNotExist').should be_nil
      end
      it 'can get the views x position' do
        @parser.x_pos(:label => 'showAlertLabel').should == 304
      end
      it 'is nil if label not found when getting x position' do
        @parser.x_pos(:name => 'doesNotExist').should be_nil
      end
      it 'can get the views y position' do
        @parser.y_pos(:label => 'showAlertLabel').should == 302
      end
      it 'is nil if label not found when getting y position' do
        @parser.y_pos(:label => 'doesNotExist').should be_nil
      end

      it 'can get the label of the view' do
        @parser.label_for(:label => 'showAlertLabel').should eq('showAlertLabel')
      end
    end
    context 'getting view state' do
      it 'can tell if the view is enabled' do
        @parser.enabled?(:label => 'showAlertLabel').should be_true
      end
      it 'can tell if the view is visible' do
        @parser.displayed?(:label => 'showAlertLabel').should be_true
      end
      context 'view does not exist in hierarchy data' do
        it 'return false when checking enabled state' do
          @parser.enabled?(:label => 'unknownView').should be_false
        end
        it 'returns false when checking displayed state' do
          @parser.displayed?(:label => 'unknownView').should be_false
        end
      end
    end
  end
  context 'getting nested views' do
    view_data = "{\"name\":\"showAlertButton\",\"type\":\"UIAButton\",\"label\":\"showAlertLabel\",\"value\":null,\"rect\":{\"origin\":{\"x\":304,\"y\":302},\"size\":{\"width\":150,\"height\":30}},\"dom\":null,\"enabled\":true,\"valid\":true,\"visible\":true,\"children\":[{\"name\":\"firstChild\",\"type\":\"UIAImage\",\"label\":\"firstChildLabel\",\"value\":null,\"rect\":{\"origin\":{\"x\":0,\"y\":1023},\"size\":{\"width\":768,\"height\":1}},\"dom\":null,\"enabled\":true,\"valid\":true,\"visible\":true,\"children\":[{\"name\":\"firstNested\",\"type\":\"UIAStaticText\",\"label\":\"showAlertButton\",\"value\":null,\"rect\":{\"origin\":{\"x\":0,\"y\":1024},\"size\":{\"width\":668,\"height\":44}},\"dom\":null,\"enabled\":true,\"valid\":true,\"visible\":true,\"children\":[]}]},{\"name\":\"secondChild\",\"type\":\"UIAButton\",\"label\":\"secondChildLabel\",\"value\":null,\"rect\":{\"origin\":{\"x\":0,\"y\":1024},\"size\":{\"width\":568,\"height\":34}},\"dom\":null,\"enabled\":true,\"valid\":true,\"visible\":true,\"children\":[{\"name\":\"childOfSecondChild\",\"type\":\"UIATableViewCell\",\"label\":\"childOfSecondChildLabel\",\"value\":null,\"rect\":{\"origin\":{\"x\":0,\"y\":1024},\"size\":{\"width\":468,\"height\":24}},\"dom\":null,\"enabled\":true,\"valid\":true,\"visible\":true,\"children\":[]}]}]}"
    before(:each) do
      @parser = Rufus::Parser.new(view_data)
    end
    it 'can get the root view' do
      @parser.view_by_label(:label => 'showAlertLabel').should == {"name"=>"showAlertButton", "type"=>"UIAButton", "label"=>"showAlertLabel", "value"=>nil, "rect"=>{"origin"=>{"x"=>304, "y"=>302}, "size"=>{"width"=>150, "height"=>30}}, "dom"=>nil, "enabled"=>true, "valid"=>true, "visible"=>true, "children"=>[{"name"=>"firstChild", "type"=>"UIAImage", "label"=>"firstChildLabel", "value"=>nil, "rect"=>{"origin"=>{"x"=>0, "y"=>1023}, "size"=>{"width"=>768, "height"=>1}}, "dom"=>nil, "enabled"=>true, "valid"=>true, "visible"=>true, "children"=>[{"name"=>"firstNested", "type"=>"UIAStaticText", "label"=>"showAlertButton", "value"=>nil, "rect"=>{"origin"=>{"x"=>0, "y"=>1024}, "size"=>{"width"=>668, "height"=>44}}, "dom"=>nil, "enabled"=>true, "valid"=>true, "visible"=>true, "children"=>[]}]}, {"name"=>"secondChild", "type"=>"UIAButton", "label"=>"secondChildLabel", "value"=>nil, "rect"=>{"origin"=>{"x"=>0, "y"=>1024}, "size"=>{"width"=>568, "height"=>34}}, "dom"=>nil, "enabled"=>true, "valid"=>true, "visible"=>true, "children"=>[{"name"=>"childOfSecondChild", "type"=>"UIATableViewCell", "label"=>"childOfSecondChildLabel", "value"=>nil, "rect"=>{"origin"=>{"x"=>0, "y"=>1024}, "size"=>{"width"=>468, "height"=>24}}, "dom"=>nil, "enabled"=>true, "valid"=>true, "visible"=>true, "children"=>[]}]}]}
    end
    it 'can get the first child of the root view by label' do
      @parser.view_by_label(:label => 'firstChildLabel').should == {"name"=>"firstChild", "type"=>"UIAImage", "label"=>"firstChildLabel", "value"=>nil, "rect"=>{"origin"=>{"x"=>0, "y"=>1023}, "size"=>{"width"=>768, "height"=>1}}, "dom"=>nil, "enabled"=>true, "valid"=>true, "visible"=>true, "children"=>[{"name"=>"firstNested", "type"=>"UIAStaticText", "label"=>"showAlertButton", "value"=>nil, "rect"=>{"origin"=>{"x"=>0, "y"=>1024}, "size"=>{"width"=>668, "height"=>44}}, "dom"=>nil, "enabled"=>true, "valid"=>true, "visible"=>true, "children"=>[]}]}
    end
    it 'can get the second child of the root view by label' do
      @parser.view_by_label(:label => 'secondChildLabel').should == {"name"=>"secondChild", "type"=>"UIAButton", "label"=>"secondChildLabel", "value"=>nil, "rect"=>{"origin"=>{"x"=>0, "y"=>1024}, "size"=>{"width"=>568, "height"=>34}}, "dom"=>nil, "enabled"=>true, "valid"=>true, "visible"=>true, "children"=>[{"name"=>"childOfSecondChild", "type"=>"UIATableViewCell", "label"=>"childOfSecondChildLabel", "value"=>nil, "rect"=>{"origin"=>{"x"=>0, "y"=>1024}, "size"=>{"width"=>468, "height"=>24}}, "dom"=>nil, "enabled"=>true, "valid"=>true, "visible"=>true, "children"=>[]}]}
    end

    it 'can get a child of the root views first child by label' do
      @parser.view_by_label(:label => 'childOfSecondChildLabel').should == {"name"=>"childOfSecondChild", "type"=>"UIATableViewCell", "label"=>"childOfSecondChildLabel", "value"=>nil, "rect"=>{"origin"=>{"x"=>0, "y"=>1024}, "size"=>{"width"=>468, "height"=>24}}, "dom"=>nil, "enabled"=>true, "valid"=>true, "visible"=>true, "children"=>[]}
    end
  end



end