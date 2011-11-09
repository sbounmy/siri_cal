require 'test_helper'

class InstallGeneratorTest < Rails::Generators::TestCase
  tests SiriCal::Generators::InstallGenerator
  destination File.expand_path("../../../tmp", __FILE__)
  setup :prepare_destination

  test "assert a siri_says base step is properly created" do
    run_generator
    assert_file "lib/siri_says/default.rb", /says \/\^\(\?\:\|a \)movie \(\.\+\)\$\//
    assert_file "config/initializers/siri_cal.rb"
  end
end