# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "rails/test_help"
require 'rails/generators/test_case'
require 'vcr'
require 'shoulda-context'

VCR.config do |c|
  c.default_cassette_options = { :record => :new_episodes }
  c.cassette_library_dir = 'test/fixtures/vcr_cassettes'
  c.stub_with :fakeweb # or :fakeweb
end

Rails.backtrace_cleaner.remove_silencers!

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

SiriCal.setup do |config|
  config.siri_says_path = "test/dummy/lib/siri_says"
end
