require 'spec_helper'

describe Zippopotamus do

  context "VCR enabled tests" do

    context "valid postal_code with single Place returned" do
      before do
        VCR.use_cassette 'us_90210' do
          @result = Zippopotamus.lookup_postal_code!('90210')
        end
      end

      it "returns correct data" do
        @result.should be_a(Zippopotamus::Place)
        @result.name.should == 'Beverly Hills'
        @result.region.should == 'California'
        @result.region_code.should == 'CA'
        @result.latitude.should be_within(2.0).of(34.0)
        @result.longitude.should be_within(2.0).of(-118.4)
      end
    end



    context "valid postal_code with multiple Places returned" do
      before do
        VCR.use_cassette 'fr_01000' do
          @result = Zippopotamus.lookup_postal_code!('01000', 'fr')
        end
      end

      it "returns correct data" do
        @result.should be_a(Zippopotamus::Place)
        @result.name.should == 'Bourg-en-Bresse'
        @result.region.should == 'Rhône-Alpes'
        @result.region_code.should == 'B9'
        @result.latitude.should be_within(2.0).of(46.2)
        @result.longitude.should be_within(2.0).of(5.2)
        @result.has_alternatives?.should be_true

        @result.alternatives[0].name.should == 'Saint-Denis-lès-Bourg'
      end
    end


    context "invalid postal_code or country" do
      before do
        VCR.use_cassette 'xx_1234' do
          @result = Zippopotamus.lookup_postal_code('1234', 'xx')
        end
      end


      it "returns nil" do
        @result.should be_nil
      end
    end

  end




  context "live HTTP tests with US/90210 valid data" do

    before do
      @result = Zippopotamus.lookup_postal_code!('90210')
    end

    it "returns correct data" do
      @result.should be_a(Zippopotamus::Place)
      @result.name.should == 'Beverly Hills'
      @result.region.should == 'California'
      @result.region_code.should == 'CA'
      @result.latitude.should be_within(2.0).of(34.0)
      @result.longitude.should be_within(2.0).of(-118.4)
    end

  end


end


