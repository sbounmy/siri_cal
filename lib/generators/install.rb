module SiriCal
  module Generators
    class InstallGenerator < Rails::Generators::Base #:nodoc:
      source_root File.expand_path("../templates", __FILE__)
      desc "Copies siri says file"

      def copy_siri_says_default
        copy_file "siri_says/default.rb", "lib/siri_says/default.rb"
      end

      def copy_config
        copy_file "siri_cal.rb", "config/initializers/siri_cal.rb"
      end
    end
  end
end