$:.push File.expand_path("../lib", __FILE__)

# Maintain gem's version:
require "siri_cal/version"

# Gem description anddependencies:
Gem::Specification.new do |s|
  s.name        = "siri_cal"
  s.version     = SiriCal::VERSION
  s.authors     = ["Stephane Bounmy"]
  s.email       = ["stephanebounmy@gmail.com"]
  s.platform    = Gem::Platform::RUBY
  s.homepage    = "http://github.com/sbounmy/siri_cal"
  s.summary     = "A simple gem provide siri helper by using gcal events"
  s.description = "A simple gem provide siri helper by using gcal events"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "google_calendar", "0.2.0"

  s.add_development_dependency "rails", "~> 3.1.0"
  s.add_development_dependency "sqlite3"
end
