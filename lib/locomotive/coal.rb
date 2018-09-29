require 'active_support'
require 'active_support/concern'
require 'active_support/deprecation'
require 'active_support/core_ext'
require 'faraday'
require 'faraday_middleware'
require 'mime-types'

module Locomotive
  module Coal
  end
end

require_relative 'coal/error'
require_relative 'coal/upload_io'
require_relative 'coal/paginated_resources'
require_relative 'coal/resource'
require_relative 'coal/resources/base'
require_relative 'coal/resources/token'
require_relative 'coal/resources/my_account'
require_relative 'coal/resources/sites'
require_relative 'coal/resources/current_site'
require_relative 'coal/resources/pages'
require_relative 'coal/resources/snippets'
require_relative 'coal/resources/sections'
require_relative 'coal/resources/content_assets'
require_relative 'coal/resources/theme_assets'
require_relative 'coal/resources/translations'
require_relative 'coal/resources/content_types'
require_relative 'coal/resources/content_entries'
require_relative 'coal/resources/engine_version'
require_relative 'coal/resources/memberships'
require_relative 'coal/client'
require_relative 'coal/client_v2'
