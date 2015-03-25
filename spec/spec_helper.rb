require 'simplecov'
require 'codeclimate-test-reporter'
require 'coveralls'

SimpleCov.start do
  formatter SimpleCov::Formatter::MultiFormatter[
    SimpleCov::Formatter::HTMLFormatter,
    CodeClimate::TestReporter::Formatter,
    Coveralls::SimpleCov::Formatter
  ]

  add_filter 'spec/'
  add_filter 'lib/locomotive/coal/version.rb'
end

require 'rubygems'
require 'bundler/setup'

require 'webmock/rspec'
require 'vcr'

# VCR config
VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/coal_cassettes'
  c.hook_into :webmock
end

require_relative 'support/api_settings'
require_relative 'support/pry'

require_relative '../lib/locomotive/coal'

RSpec.configure do |config|
  # config.include Spec::Helpers

  # config.filter_run focused: true
  # config.run_all_when_everything_filtered = true

  # config.before { reset! }
  # config.after  { reset! }

  config.order = :random
end
