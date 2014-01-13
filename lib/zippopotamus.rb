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
# Usage
#
#   # Lookup US zip codes by default
#   Zippopotamus.lookup_postal_code('90210')
#
#   # Specify country by 2 letter code
#   Zippopotamus.lookup_postal_code('01000', 'fr')
#
#
#   # Raise an error when parameters are invalid
#   Zippopotamus.lookup_postal_code(12345)
#
module Zippopotamus

  extend self

  def configure(&block)
    block.call(get_configuration)
  end


  # lookup a postal_code for a country and return the place(s) for it
  #
  # @param [String] postal_code
  # @param [String] country 2 letter country code (default: 'us')
  # @return [Zippopotamus::Place] place with postal_code for country OR nil if not found
  # @raise if invalid parameters
  def lookup_postal_code(postal_code, country = 'us')
    @client ||= Zippopotamus::Client.new(get_configuration.use_persistent_connection)
    return @client.lookup_postal_code(postal_code, country)
  end



  private


  def get_configuration
    @configuration ||= Configuration.new
  end


end
