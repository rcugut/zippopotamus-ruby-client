require 'excon'
require 'json'

module Zippopotamus

  class Client


    def initialize(use_persistent_connection = false)
      @connection = Excon.new('http://api.zippopotam.us', persistent: use_persistent_connection)
    end



    # @param [String] postal_code
    # @param [String] country 2 letter country code (default: 'us')
    def lookup_postal_code(postal_code, country = 'us')
      postal_code = postal_code.to_s if postal_code.is_a?(Integer)
      raise "Invalid postal_code parameter: '#{postal_code}'" if not_blank_string?(postal_code)
      raise "Invalid country parameter: '#{country}'" if not_blank_string?(country) || country.length != 2
      country = country.downcase
      begin
        r = @connection.get(path: "/#{country}/#{postal_code}")
      rescue Excon::Errors::SocketError
        # just retry
        r = @connection.get(path: "/#{country}/#{postal_code}")
      end
      if r.status == 200
        return Place.new(*JSON.parse(r.body)['places'])
      else
        return nil
      end
    end


    private

    def not_blank_string?(str)
      str.nil? || ( ! str.is_a?(String)) || str.strip.length == 0
    end

  end





  class Place

    attr_reader :name, :region, :region_code, :latitude, :longitude
    attr_reader :alternatives

    def initialize(*places)
      place = places.shift
      @name = place['place name']
      @region = place['state']
      @region_code = place['state abbreviation']
      @latitude = place['latitude'].to_f if place['latitude']
      @longitude = place['longitude'].to_f if place['longitude']

      @alternatives = []
      places.each do |place|
        @alternatives << Place.new(place)
      end
      @alternatives.freeze
    end


    def has_alternatives?
      @alternatives && @alternatives.length > 0
    end


    def to_s
      "#<Place name='#{name}', region='#{region} (#{region_code})', lat/lng='#{latitude},#{longitude}'#{has_alternatives? ? " alternatives=[#{alternatives.map(&:name).join(',')}]" : ''}>"
    end

  end


end
