require 'spec_helper'
require 'json'

describe Zippopotamus::Place do

  DATA_SINGLE_PLACE = [{"place name"=>"Beverly Hills", "longitude"=>"-118.4065", "state"=>"California", "state abbreviation"=>"CA", "latitude"=>"34.0901"}]
  DATA_MULTI_PLACE = [{"place name"=>"Bourg-en-Bresse", "longitude"=>"5.2258", "state"=>"Rhône-Alpes", "state abbreviation"=>"B9", "latitude"=>"46.2057"},
                      {"place name"=>"Saint-Denis-lès-Bourg", "longitude"=>"5.1892", "state"=>"Rhône-Alpes", "state abbreviation"=>"B9", "latitude"=>"46.2022"}]

  context "with single place" do
    before do
      @place = Zippopotamus::Place.new('90210', *DATA_SINGLE_PLACE)
    end

    it "is a valid Place without alternatives" do
      @place.postcode.should == '90210'
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
      @place = Zippopotamus::Place.new('01000', *DATA_MULTI_PLACE)
    end

    it "is a valid Place without alternatives" do
      @place.postcode.should == '01000'
      @place.name.should == 'Bourg-en-Bresse'
      @place.region.should == 'Rhône-Alpes'
      @place.region_code.should == 'B9'
      @place.has_alternatives?.should be_true
    end

    it "has valid values for alternative Places" do
      place1 = @place.alternatives[0]
      place1.should be_a(Zippopotamus::Place)
      place1.postcode.should == '01000'
      place1.name.should == 'Saint-Denis-lès-Bourg'
      place1.region.should == 'Rhône-Alpes'
      place1.region_code.should == 'B9'
    end

  end

end
