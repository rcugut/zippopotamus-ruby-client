require 'zippopotamus/version'
require 'zippopotamus/configuration'
require 'zippopotamus/client'


# Configure
#
#   Zippopotamus.configure do |c|
#     # enable `use_persistent_connection` to keep the connection alive between subsequent calls
#     c.use_persistent_connection = fase # default: true
#   end
#
#
#
# Use
#
#   # Lookup US zip codes by default
#   Zippopotamus.lookup_postcode('90210')
#
#   # Specify country by 2 letter code
#   Zippopotamus.lookup_postcode('01000', 'fr')
#
module Zippopotamus

  extend self

  def configure(&block)
    block.call(get_configuration)
  end


  # lookup a postcode for a country and return the place(s) for it
  #
  # @param [String] postcode
  # @param [String] country 2 letter country code (default: 'us')
  # @return [Zippopotamus::Place] place with postal_code for country OR nil if not found
  # @raise if invalid parameters
  def lookup_postcode(postcode, country = 'us')
    @client ||= Zippopotamus::Client.new(get_configuration.use_persistent_connection)
    return @client.lookup_postcode(postcode, country)
  end

  alias_method :lookup_zipcode, :lookup_postcode
  alias_method :lookup_postal_code, :lookup_postcode

  private


  def get_configuration
    @configuration ||= Configuration.new
  end


end
