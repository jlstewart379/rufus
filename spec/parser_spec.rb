require 'spec_helper'
require 'rufus/parser'



describe Rufus::Parser do


  context 'initializing' do
    context 'json is valid' do
      let(:valid){'{"name":"RufusApp","type":"UIAApplication","label":"RufusApp","value":null,"rect":{"origin":{"x":0,"y":20},"size":{"width":768,"height":1004}},"dom":null,"enabled":true,"valid":true,"visible":true,"children":"[]"}'}
      before(:each) do
        @parser = Rufus::Parser.new(valid)
      end
      it 'loads the json' do
        @parser.screen_data.should eq MultiJson.load(valid)
      end
    end
    context 'json is invalid' do
      let(:invalid){'This is not json'}
      it 'does not like invalid json' do
       expect{Rufus::Parser.new(invalid).to raise_error(MultiJson::LoadError)}
      end
    end
  end
end