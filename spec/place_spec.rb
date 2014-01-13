require 'spec_helper'
require 'json'

describe Zippopotamus::Place do

  DATA_WO_ALTERNATIVES = [{"place name"=>"Beverly Hills", "longitude"=>"-118.4065", "state"=>"California", "state abbreviation"=>"CA", "latitude"=>"34.0901"}]
  DATA_WITH_ALTERNATIVES = [{"place name"=>"Bourg-en-Bresse", "longitude"=>"5.2258", "state"=>"Rhône-Alpes", "state abbreviation"=>"B9", "latitude"=>"46.2057"},
                            {"place name"=>"Saint-Denis-lès-Bourg", "longitude"=>"5.1892", "state"=>"Rhône-Alpes", "state abbreviation"=>"B9", "latitude"=>"46.2022"}]

  context "with no alternative places" do
    before do
      @place = Zippopotamus::Place.new(*DATA_WO_ALTERNATIVES)
    end

    it "is a valid Place without alternatives" do
      @place.name.should == 'Beverly Hills'
      @place.region.should == 'California'
      @place.region_code.should == 'CA'
      @place.latitude.should be_within(1.0).of(34.0)
      @place.longitude.should be_within(1.0).of(-118.4)
      @place.has_alternatives?.should be_false
    end
  end


  context "with multiple alternative places" do
    before do
      @place = Zippopotamus::Place.new(*DATA_WITH_ALTERNATIVES)
    end

    it "is a valid Place without alternatives" do
      @place.name.should == 'Bourg-en-Bresse'
      @place.region.should == 'Rhône-Alpes'
      @place.region_code.should == 'B9'
      @place.has_alternatives?.should be_true
    end

    it "has valid values for alternative Place" do
      place1 = @place.alternatives[0]
      place1.should be_a(Zippopotamus::Place)
      place1.name.should == 'Saint-Denis-lès-Bourg'
      place1.region.should == 'Rhône-Alpes'
      place1.region_code.should == 'B9'
    end

  end

end
