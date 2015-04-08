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

Dir["#{File.expand_path('../support', __FILE__)}/*.rb"].each do |file|
  require file
end

require_relative '../lib/locomotive/coal'

RSpec.configure do |config|
  # config.include Spec::Helpers

  # config.filter_run focused: true
  # config.run_all_when_everything_filtered = true

  # config.before { reset! }
  # config.after  { reset! }

  config.order = :random
end
