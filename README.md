# Zippopotamus Client (for Ruby)

This is a simple ruby client for the [zippopotam.us](http://zippopotam.us) API.
It uses [excon](https://github.com/geemus/excon) http client for it's speed and persistent connections support.

[![Gem Version](https://badge.fury.io/rb/zippopotamus-client.png)](http://badge.fury.io/rb/zippopotamus-client)


## Installation

Add this line to your application's Gemfile:

    gem 'zippopotamus-client'

And then execute:

    $ bundle

Or install the gem via command line:

    $ gem install zippopotamus-client


## Usage

#### Configure

```ruby
require 'zippopotamus'

Zippopotamus.configure do |c|
  # enable `use_persistent_connection` to keep the connection alive between subsequent calls
  c.use_persistent_connection = false # default: true
end
```

#### Use

```ruby
# Lookup a zip code (by default country = US)
place = Zippopotamus.lookup_postcode('90210')
# or the alias method lookup_zipcode
place = Zippopotamus.lookup_zipcode('90210')

# place is a <Zippopotamus::Place>
#    @postcode: '90210'
#    @name: 'Beverly Hills'
#    @region: 'California'
#    @region_code: 'CA'
#    @latitude: 34.0901
#    @longitude: -118.4065
#    @alternatives: []
#    #has_alternatives?: false



# Lookup a postcode in France, with multiple place results (alternatives)
place = Zippopotamus.lookup_postcode('01000', 'fr')

# returns the first Place in the list of multiple places
puts place.name
#> 'Bourg-en-Bresse'

# this place has alternatives (with same postal_code)
puts place.has_alternatives?
#> true

# get array of Zippotamus::Place representing alternatives (with the same postcode)
puts place.alternatives
#> [#<Place @name="Saint-Denis-lès-Bourg", @region="Rhône-Alpes", @region_code="B9", @latitude=46.2022, @longitude=5.1892>]



# Works if postcode is a number (although not recommended)
Zippopotamus.lookup_postcode(90210)
#=> #<Place @name="Beverly Hills", @region="California", @region_code="CA", @latitude=34.0901, @longitude=-118.4065, @alternatives=[]>
```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


## Special thanks

Special thanks to [zippopotam.us](http://zippopotam.us) project for the postal codes database and API hosting/maintenance

