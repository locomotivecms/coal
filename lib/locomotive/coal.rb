require 'active_support'
require 'active_support/concern'
require 'active_support/deprecation'
require 'active_support/core_ext'
# require 'unirest'
require 'faraday'
require 'faraday_middleware'

module Locomotive
  module Coal
  end
end

require_relative 'coal/error'
require_relative 'coal/request'
require_relative 'coal/paginated_resources'
require_relative 'coal/resource'
require_relative 'coal/resources/token'
require_relative 'coal/resources/my_account'
require_relative 'coal/resources/sites'
require_relative 'coal/resources/contents'
require_relative 'coal/resources/content_entries'
require_relative 'coal/client'
